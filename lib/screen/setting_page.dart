import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:d_counter/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  final String? initialName;
  final DateTime? initialDate;
  final DateType? initialDateType;
  final VoidCallback onSave;

  const SettingPage({
    super.key,
    this.initialName,
    this.initialDate,
    this.initialDateType,
    required this.onSave,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _controller = TextEditingController();

  late DateTime date;
  late DateType dateType;

  @override
  void initState() {
    super.initState();
    if (widget.initialName != null) {
      _controller.text = widget.initialName!;
    }
    date = widget.initialDate ?? DateTime.now();
    dateType = widget.initialDateType ?? DateType.dDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 날짜 종류
                  const Text(
                    '날짜 종류',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.pink.shade50)),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                dateType = DateType.dDay;
                              });
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: dateType == DateType.dDay ? Colors.pink.shade50 : Colors.transparent,
                                border: Border.all(
                                  color: dateType == DateType.dDay ? Colors.pink : Colors.transparent,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: Text(
                                DateType.dDay.name,
                                style: TextStyle(
                                  color: dateType == DateType.dDay ? Colors.pink : Colors.black,
                                  fontSize: 16,
                                  fontWeight: dateType == DateType.dDay ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                dateType = DateType.anniversary;
                              });
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: dateType == DateType.anniversary ? Colors.pink.shade50 : Colors.transparent,
                                border: Border.all(
                                  color: dateType == DateType.anniversary ? Colors.pink : Colors.transparent,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: Text(
                                DateType.anniversary.name,
                                style: TextStyle(
                                  color: dateType == DateType.anniversary ? Colors.pink : Colors.black,
                                  fontSize: 16,
                                  fontWeight: dateType == DateType.anniversary ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dateType.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 26),

                  /// 날짜 이름
                  Row(
                    children: [
                      Text(
                        '${dateType.name} 이름',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink.shade50)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
                            hintText: '이름을 입력하세요 (선택)',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),

                  // 날짜
                  Row(
                    children: [
                      Text(
                        '${dateType.name} 날짜',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.pink.shade300,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat('yyyy.MM.dd.').format(date),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.pink.shade300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// 캘린더
                  Container(
                    color: Colors.pink.withAlpha(10),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        // calendarViewScrollPhysics
                        selectedDayHighlightColor: Colors.pink,
                        daySplashColor: Colors.transparent,
                      ),
                      value: [date],
                      onValueChanged: (dates) {
                        setState(() {
                          date = dates.first;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 40),

                  /// 버튼
                  GestureDetector(
                    onTap: () async {
                      final SharedPreferencesWithCache prefs = await prefsWithCache;

                      await prefs.setInt('dateType', dateType.index);
                      await prefs.setString('dateName', _controller.text);
                      await prefs.setString('dateDate', DateFormat('yyyy-MM-dd').format(date));

                      widget.onSave.call();

                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade400,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '저장',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum DateType {
  dDay('디데이', '지정한 날짜를 D+0으로 계산합니다.'),
  anniversary('기념일', '지정한 날짜를 D+1으로 계산합니다.');

  final String name;
  final String description;

  const DateType(this.name, this.description);
}
