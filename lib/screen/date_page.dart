import 'package:d_counter/main.dart';
import 'package:d_counter/screen/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePage extends StatelessWidget {
  final DateTime date;
  final DateType type;
  final String? name;
  final int background;
  final int font;

  const DatePage({
    super.key,
    required this.date,
    required this.type,
    this.name,
    required this.background,
    required this.font,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background${background + 1}.jpg'),
              colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.darken),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (name != null && name!.isNotEmpty) ...[
              Text(
                name!,
                style: TextStyle(
                  fontFamily: fontFamily[font],
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              DateFormat('yyyy.MM.dd.').format(date),
              style: TextStyle(
                fontFamily: fontFamily[font],
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: 200,
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 24),
            Text(
              _calculateDateDifference(),
              style: TextStyle(
                fontFamily: fontFamily[font],
                fontSize: 72,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ],
    );
  }

  String _calculateDateDifference() {
    final today = DateUtils.dateOnly(DateTime.now());

    if (date.isAfter(today)) {
      final difference = date.difference(today).inDays;
      return 'D-$difference';
    } else if (date.isBefore(today)) {
      final difference = today.difference(date).inDays + (type == DateType.anniversary ? 1 : 0);
      return 'D+$difference';
    } else {
      if (type == DateType.dDay) {
        return 'D-Day';
      } else {
        return 'D+1';
      }
    }
  }
}
