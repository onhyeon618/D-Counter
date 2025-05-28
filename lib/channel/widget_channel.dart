import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:d_counter/common/statics.dart';
import 'package:d_counter/widget.dart';
import 'package:flutter/services.dart';

class WidgetChannel {
  static const _channel = MethodChannel('dayone/widget_channel');

  static void init() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'registerWidget') {
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
    });
  }
}
