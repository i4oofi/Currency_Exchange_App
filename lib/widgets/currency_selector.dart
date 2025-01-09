import 'package:currency_exchange/currencies.dart';
import 'package:currency_exchange/widgets/currency_flag.dart';
import 'package:flutter/material.dart';

class CurrencySelector extends StatelessWidget {
  final String currency;
  final Function(String?) onChanged;

  const CurrencySelector({
    super.key,
    required this.currency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CurrencyFlag(currency: currency),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButton<String>(
            isExpanded: false,
            value: currency,
            underline: Container(),
            items: CurrencyData.currencies
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xff26278D),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
