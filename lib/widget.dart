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

@pragma('vm:entry-point')
Future<void> updateWidget() async {
  await updateData();

  HomeWidget.updateWidget(
    androidName: 'CountingWidgetReceiver',
  );
}
