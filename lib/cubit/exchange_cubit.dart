// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:currency_exchange/services/exchange_service.dart';
part 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final ExchangeService _exchangeService;

  ExchangeCubit(this._exchangeService) : super(ExchangeInitial());

  Future<void> fetchExchangeRate(String fromCurrency, String toCurrency) async {
    try {
      emit(ExchangeLoading());

      final rate = await _exchangeService.getRate(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      );

      emit(ExchangeSuccess(rate));
    } catch (error) {
      emit(ExchangeFailure(error.toString()));
    }
  }

  void switchCurrencies() {
    emit(state.copyWith(isSwapped: !state.isSwapped));
  }
}
