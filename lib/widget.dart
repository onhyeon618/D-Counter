import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:d_counter/common/enums.dart';
import 'package:d_counter/common/statics.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

Future<void> updateData() async {
  DateTime? dday;
  DateType type;
  int fontFamily;

  final prefs = await prefsWithCache;

  dday = DateTime.tryParse(prefs.getString('dateDate') ?? '');
  if (dday == null) return;

  type = DateType.values[prefs.getInt('dateType') ?? 0];
  fontFamily = prefs.getInt('fontFamily') ?? 0;

  final daysCount = calculateDifference(
    date: dday,
    toCompare: DateUtils.dateOnly(DateTime.now()),
    dateType: type,
  );

  HomeWidget.saveWidgetData<String>('daysCount', daysCount);
  HomeWidget.saveWidgetData<int>('fontFamily', fontFamily);
}

Future<void> updateWidget() async {
  await updateData();

  HomeWidget.updateWidget(
    androidName: 'CountingWidgetReceiver',
  );
}

@pragma('vm:entry-point')
Future<void> updateWidgetDaily() async {
  await updateWidget();

  final now = DateTime.now();
  final nextMidnight = DateTime(now.year, now.month, now.day + 1);

  await AndroidAlarmManager.oneShotAt(
    nextMidnight,
    widgetUpdateId,
    updateWidgetDaily,
    alarmClock: true,
    wakeup: true,
    rescheduleOnReboot: true,
  );
}
