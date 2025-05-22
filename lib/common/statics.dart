import 'package:d_counter/common/enums.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferencesWithCache> prefsWithCache = SharedPreferencesWithCache.create(
  cacheOptions: const SharedPreferencesWithCacheOptions(
    allowList: <String>{'dateType', 'dateName', 'dateDate', 'backgroundImage', 'fontFamily'},
  ),
);

final List<String> fontFamily = ['Doldam', 'Dongle', 'Esamanru', 'Jikji', 'Kimjungchul', 'Okticon'];

String calculateDifference({
  required DateTime date,
  required DateTime toCompare,
  required DateType dateType,
}) {
  if (date.isAfter(toCompare)) {
    final difference = date.difference(toCompare).inDays;
    return 'D-$difference';
  } else if (date.isBefore(toCompare)) {
    final difference = toCompare.difference(date).inDays + (dateType == DateType.anniversary ? 1 : 0);
    return 'D+$difference';
  } else {
    if (dateType == DateType.dDay) {
      return 'D-Day';
    } else {
      return 'D+1';
    }
  }
}

String calculateDate({
  required DateTime date,
  required int toCompare,
  required DateType dateType,
}) {
  if (dateType == DateType.anniversary && toCompare <= 0) {
    return '(기념일 계산은 양수만 가능합니다)';
  }

  final arranged = toCompare - (dateType == DateType.anniversary ? 1 : 0);
  DateTime result = date.add(Duration(days: arranged));

  return DateFormat('yyyy년 M월 d일').format(result);
}
