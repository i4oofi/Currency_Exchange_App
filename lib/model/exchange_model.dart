class ExchangeModel {
  final String baseCurrency;
  final Map<String, dynamic> conversionRates;

  ExchangeModel({
    required this.baseCurrency,
    required this.conversionRates,
  });

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      baseCurrency: json['base_code'],
      conversionRates: Map<String, dynamic>.from(json['conversion_rates']),
    );
  }
}
