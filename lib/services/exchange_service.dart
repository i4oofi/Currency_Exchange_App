import 'package:currency_exchange/helper/api.dart';
import 'package:currency_exchange/model/cached_exchange_rate.dart';
import 'package:currency_exchange/model/exchange_model.dart';
import 'package:hive/hive.dart';

class ExchangeService {
  final Api _api;
  final String _baseUrl;
  final String _apiKey;
  final HiveExchangeCache cache;

  ExchangeService({
    Api? api,
    String baseUrl = "https://v6.exchangerate-api.com/v6",
    String apiKey = "608f6bfe7beecde6663cae10",
    required this.cache,
  })  : _api = api ?? Api(),
        _baseUrl = baseUrl,
        _apiKey = apiKey;

  Future<double> getRate({
    required String fromCurrency,
    required String toCurrency,
  }) async {
    try {
      if (fromCurrency == toCurrency) {
        return 1.0;
      }

      final exchangeModel = await fetchExchangeRates(fromCurrency);
      if (!exchangeModel.conversionRates.containsKey(toCurrency)) {
        throw Exception('The required currency is not available');
      }
      return exchangeModel.conversionRates[toCurrency]!;
    } catch (e) {
      final cachedRates = cache.getLatestRates();
      if (cachedRates != null &&
          cachedRates.baseCurrency == fromCurrency &&
          cachedRates.conversionRates.containsKey(toCurrency)) {
        return cachedRates.conversionRates[toCurrency]!;
      }
      throw Exception('Failed to get exchange rate: $e');
    }
  }

  Future<ExchangeModel> fetchExchangeRates(String baseCurrency) async {
    try {
      final String url = "$_baseUrl/$_apiKey/latest/$baseCurrency";
      final data = await _api.get(url: url);
      final exchangeModel = ExchangeModel.fromJson(data);

      await cache.cacheRates(exchangeModel);

      return exchangeModel;
    } catch (e) {
      final cachedRates = cache.getLatestRates();
      if (cachedRates != null && cachedRates.baseCurrency == baseCurrency) {
        return cachedRates.toExchangeModel();
      }
      throw Exception('Failed to bring exchange rates: $e');
    }
  }
}

class HiveExchangeCache {
  final Box<CachedExchangeRate> box;

  HiveExchangeCache({required this.box});

  Future<void> cacheRates(ExchangeModel rates) async {
    final cachedRate = CachedExchangeRate.fromExchangeModel(rates);
    await box.put('latest_rates', cachedRate);
  }

  CachedExchangeRate? getLatestRates() {
    return box.get('latest_rates');
  }
}
