import 'package:currency_exchange/cubit/exchange_cubit.dart';
import 'package:currency_exchange/widgets/currency_input_field.dart';
import 'package:currency_exchange/widgets/switch_currency_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterCard extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;
  final TextEditingController amountController;
  final TextEditingController convertedAmountController;
  final Function(String? from, String? to) onCurrencyChanged;
  final Function(ExchangeSuccess state, bool isFromAmount) onAmountChanged;

  const ConverterCard({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amountController,
    required this.convertedAmountController,
    required this.onCurrencyChanged,
    required this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CurrencyInputField(
            label: 'Amount',
            currency: fromCurrency,
            controller: amountController,
            onCurrencyChanged: (value) => onCurrencyChanged(value, null),
            onAmountChanged: (state) => onAmountChanged(state, true),
          ),
          SwitchCurrencyButton(
            onSwitch: () {
              context.read<ExchangeCubit>().switchCurrencies();
            },
          ),
          CurrencyInputField(
            label: 'Converted Amount',
            currency: toCurrency,
            controller: convertedAmountController,
            onCurrencyChanged: (value) => onCurrencyChanged(null, value),
            onAmountChanged: (state) => onAmountChanged(state, false),
          ),
        ],
      ),
    );
  }
}
