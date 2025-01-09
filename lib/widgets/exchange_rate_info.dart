import 'package:currency_exchange/cubit/exchange_cubit.dart';
import 'package:flutter/material.dart';

class ExchangeRateInfo extends StatelessWidget {
  final ExchangeState state;
  final String fromCurrency;
  final String toCurrency;

  const ExchangeRateInfo({
    super.key,
    required this.state,
    required this.fromCurrency,
    required this.toCurrency,
  });

  @override
  Widget build(BuildContext context) {
    if (state is ExchangeSuccess) {
      final rate = (state as ExchangeSuccess).rate;
      return Column(
        children: [
          const Text(
            'Indicative Exchange Rate',
            style: TextStyle(fontSize: 16, color: Color(0xff808080)),
          ),
          const SizedBox(height: 4),
          Text(
            '1 $fromCurrency = ${rate.toStringAsFixed(4)} $toCurrency',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
