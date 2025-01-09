import 'package:currency_exchange/model/exchange_model.dart';
import 'package:hive/hive.dart';
part 'cached_exchange_rate.g.dart';

@HiveType(typeId: 0)
class CachedExchangeRate extends HiveObject {
  @HiveField(0)
  final String baseCurrency;

  @HiveField(1)
  final Map<String, double> conversionRates;

  @HiveField(2)
  final DateTime lastUpdated;

  CachedExchangeRate({
    required this.baseCurrency,
    required this.conversionRates,
    required this.lastUpdated,
  });

  factory CachedExchangeRate.fromExchangeModel(ExchangeModel model) {
    Map<String, double> convertedRates = {};
    model.conversionRates.forEach((key, value) {
      if (value is int) {
        convertedRates[key] = value.toDouble();
      } else if (value is double) {
        convertedRates[key] = value;
      } else if (value is String) {
        convertedRates[key] = double.tryParse(value) ?? 0.0;
      }
    });

    return CachedExchangeRate(
      baseCurrency: model.baseCurrency,
      conversionRates: convertedRates,
      lastUpdated: DateTime.now(),
    );
  }

  ExchangeModel toExchangeModel() {
    return ExchangeModel(
      baseCurrency: baseCurrency,
      conversionRates: Map<String, dynamic>.from(conversionRates),
    );
  }
}
