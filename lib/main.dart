import 'package:d_counter/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

final Future<SharedPreferencesWithCache> prefsWithCache = SharedPreferencesWithCache.create(
  cacheOptions: const SharedPreferencesWithCacheOptions(
    allowList: <String>{'dateType', 'dateName', 'dateDate', 'backgroundImage', 'fontFamily'},
  ),
);

final List<String> fontFamily = ['Doldam', 'Dongle', 'Esamanru', 'Jikji', 'Kimjungchul', 'Okticon'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('ko', ''),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        fontFamily: 'Pretendard',
      ),
      home: const DCounterHome(),
    );
  }
}
