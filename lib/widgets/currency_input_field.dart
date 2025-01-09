import 'package:currency_exchange/cubit/exchange_cubit.dart';
import 'package:currency_exchange/widgets/amount_text_field.dart';
import 'package:currency_exchange/widgets/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyInputField extends StatelessWidget {
  final String label;
  final String currency;
  final TextEditingController controller;
  final Function(String?) onCurrencyChanged;
  final Function(ExchangeSuccess) onAmountChanged;

  const CurrencyInputField({
    super.key,
    required this.label,
    required this.currency,
    required this.controller,
    required this.onCurrencyChanged,
    required this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CurrencySelector(
                  currency: currency,
                  onChanged: onCurrencyChanged,
                ),
              ),
              Expanded(
                flex: 2,
                child: AmountTextField(
                  controller: controller,
                  onChanged: (value) {
                    final state = context.read<ExchangeCubit>().state;
                    if (state is ExchangeSuccess) {
                      onAmountChanged(state);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
