import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:d_counter/common/enums.dart';
import 'package:d_counter/common/statics.dart';
import 'package:d_counter/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  final String? initialName;
  final DateTime? initialDate;
  final DateType? initialDateType;
  final int? initialBackground;
  final int? initialFont;
  final VoidCallback onSave;

  const SettingPage({
    super.key,
    this.initialName,
    this.initialDate,
    this.initialDateType,
    this.initialBackground,
    this.initialFont,
    required this.onSave,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _controller = TextEditingController();

  late DateTime date;
  late DateType dateType;
  late int background;
  late int font;

  @override
  void initState() {
    super.initState();
    if (widget.initialName != null) {
      _controller.text = widget.initialName!;
    }
    date = widget.initialDate ?? DateTime.now();
    dateType = widget.initialDateType ?? DateType.dDay;
    background = widget.initialBackground ?? 0;
    font = widget.initialFont ?? 0;
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

                  /// 날짜
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
                  const SizedBox(height: 26),

                  /// 배경 이미지
                  Text(
                    '배경 이미지',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            background = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: background == index ? Colors.pink : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/images/background${index + 1}.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const SizedBox(height: 26),

                  /// 폰트
                  Text(
                    '글씨체',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 44,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            font = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: font == index ? Colors.pink : Colors.pink.shade50,
                              width: font == index ? 2 : 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '우린 D+123',
                            style: TextStyle(
                              fontFamily: fontFamily[index],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const SizedBox(height: 40),

                  /// 버튼
                  GestureDetector(
                    onTap: () async {
                      final SharedPreferencesWithCache prefs = await prefsWithCache;

                      await prefs.setInt('dateType', dateType.index);
                      await prefs.setString('dateName', _controller.text);
                      await prefs.setString('dateDate', DateFormat('yyyy-MM-dd').format(date));
                      await prefs.setInt('backgroundImage', background);
                      await prefs.setInt('fontFamily', font);

                      updateWidget();
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
