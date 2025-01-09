import 'package:flutter/material.dart';

class CurrencyFlag extends StatelessWidget {
  final String currency;

  const CurrencyFlag({
    super.key,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            'https://flagcdn.com/w80/${currency.substring(0, 2).toLowerCase()}.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
