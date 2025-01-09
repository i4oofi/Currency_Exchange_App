part of 'exchange_cubit.dart';

abstract class ExchangeState {
  final bool isSwapped;

  ExchangeState({this.isSwapped = false});

  ExchangeState copyWith({bool? isSwapped});
}

class ExchangeInitial extends ExchangeState {
  ExchangeInitial({super.isSwapped});

  @override
  ExchangeState copyWith({bool? isSwapped}) {
    return ExchangeInitial(isSwapped: isSwapped ?? this.isSwapped);
  }
}

class ExchangeLoading extends ExchangeState {
  ExchangeLoading({super.isSwapped});

  @override
  ExchangeState copyWith({bool? isSwapped}) {
    return ExchangeLoading(isSwapped: isSwapped ?? this.isSwapped);
  }
}

class ExchangeSuccess extends ExchangeState {
  final double rate;

  ExchangeSuccess(this.rate, {super.isSwapped});

  @override
  ExchangeState copyWith({bool? isSwapped}) {
    return ExchangeSuccess(
      rate,
      isSwapped: isSwapped ?? this.isSwapped,
    );
  }
}

class ExchangeFailure extends ExchangeState {
  final String error;

  ExchangeFailure(this.error, {super.isSwapped});

  @override
  ExchangeState copyWith({bool? isSwapped}) {
    return ExchangeFailure(
      error,
      isSwapped: isSwapped ?? this.isSwapped,
    );
  }
}
