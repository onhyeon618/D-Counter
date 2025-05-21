import 'package:d_counter/enums.dart';
import 'package:d_counter/statics.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

void updateData() {
  DateTime? dday;
  DateType type;
  int fontFamily;

  prefsWithCache.then((prefs) {
    dday = DateTime.tryParse(prefs.getString('dateDate') ?? '');
    if (dday == null) return;

    type = DateType.values[prefs.getInt('dateType') ?? 0];
    fontFamily = prefs.getInt('fontFamily') ?? 0;

    final daysCount = calculateDifference(
      date: dday!,
      toCompare: DateUtils.dateOnly(DateTime.now()),
      dateType: type,
    );

    HomeWidget.saveWidgetData<String>('daysCount', daysCount);
    HomeWidget.saveWidgetData<int>('fontFamily', fontFamily);
  });
}

void updateWidget() {
  updateData();

  HomeWidget.updateWidget(
    androidName: 'CountingWidgetReceiver',
  );
}