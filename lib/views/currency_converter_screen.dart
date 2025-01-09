import 'package:currency_exchange/cubit/exchange_cubit.dart';
import 'package:currency_exchange/widgets/converter_card.dart';
import 'package:currency_exchange/widgets/exchange_rate_info.dart';
import 'package:currency_exchange/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController convertedAmountController =
      TextEditingController();
  String fromCurrency = 'USD';
  String toCurrency = 'EGP';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchExchangeRate();
    });
  }

  void _fetchExchangeRate() {
    context.read<ExchangeCubit>().fetchExchangeRate(fromCurrency, toCurrency);
  }

  void _updateConversion(ExchangeSuccess state, bool isFromAmount) {
    if (isFromAmount) {
      _updateToAmount(state.rate);
    } else {
      _updateFromAmount(state.rate);
    }
  }

  void _updateToAmount(double rate) {
    if (amountController.text.isNotEmpty) {
      double amount = double.tryParse(amountController.text) ?? 0;
      double convertedAmount = amount * rate;
      convertedAmountController.text = convertedAmount.toStringAsFixed(2);
    } else {
      convertedAmountController.clear();
    }
  }

  void _updateFromAmount(double rate) {
    if (convertedAmountController.text.isNotEmpty) {
      double convertedAmount =
          double.tryParse(convertedAmountController.text) ?? 0;
      double amount = convertedAmount / rate;
      amountController.text = amount.toStringAsFixed(2);
    } else {
      amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50.withOpacity(0.9),
              Colors.white,
            ],
            stops: const [0.0, 0.7],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: 16.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        const HeaderSection(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        BlocBuilder<ExchangeCubit, ExchangeState>(
                          builder: (context, state) {
                            return ConverterCard(
                              fromCurrency: fromCurrency,
                              toCurrency: toCurrency,
                              amountController: amountController,
                              convertedAmountController:
                                  convertedAmountController,
                              onCurrencyChanged: (from, to) {
                                setState(() {
                                  fromCurrency = from ?? fromCurrency;
                                  toCurrency = to ?? toCurrency;
                                });
                                _fetchExchangeRate();
                              },
                              onAmountChanged: (exchangeState, isFromAmount) {
                                _updateConversion(exchangeState, isFromAmount);
                              },
                            );
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        BlocBuilder<ExchangeCubit, ExchangeState>(
                          builder: (context, state) => ExchangeRateInfo(
                            state: state,
                            fromCurrency: fromCurrency,
                            toCurrency: toCurrency,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    convertedAmountController.dispose();
    super.dispose();
  }
}
