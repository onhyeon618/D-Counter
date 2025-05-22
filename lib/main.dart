import 'package:d_counter/home.dart';
import 'package:d_counter/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    updateWidget();
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);

  final now = DateTime.now();
  final nextMidnight = DateTime(now.year, now.month, now.day + 1);
  final initialDelay = nextMidnight.difference(now);

  Workmanager().registerPeriodicTask(
    'midnight-update-task',
    'midnightUpdateTask',
    frequency: const Duration(hours: 24),
    initialDelay: initialDelay,
    existingWorkPolicy: ExistingWorkPolicy.replace,
  );

  runApp(const MyApp());
}

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
