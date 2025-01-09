import 'package:currency_exchange/cubit/exchange_cubit.dart';
import 'package:currency_exchange/model/cached_exchange_rate.dart';
import 'package:currency_exchange/services/exchange_service.dart';
import 'package:currency_exchange/views/currency_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(CachedExchangeRateAdapter());

  await Hive.openBox<CachedExchangeRate>('exchange_rates');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ExchangeCubit(
          ExchangeService(
            cache: HiveExchangeCache(
              box: Hive.box<CachedExchangeRate>('exchange_rates'),
            ),
          ),
        ),
        child: const CurrencyConverterScreen(),
      ),
    );
  }
}
