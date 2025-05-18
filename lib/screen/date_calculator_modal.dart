import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:d_counter/enums.dart';
import 'package:d_counter/statics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCalculatorModal extends StatefulWidget {
  final DateTime date;

  const DateCalculatorModal({
    super.key,
    required this.date,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required DateTime date,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DateCalculatorModal(date: date),
      ),
    );
  }

  @override
  State<DateCalculatorModal> createState() => _DateCalculatorModalState();
}

class _DateCalculatorModalState extends State<DateCalculatorModal> {
  final TextEditingController _controller = TextEditingController(text: '+1');

  DateType dateType = DateType.dDay;
  CalculationType calculationType = CalculationType.byDate;
  DateTime comparedDate = DateTime.now();
  String calculatedDate = '';

  @override
  void initState() {
    super.initState();
    calculatedDate = calculateDate(date: widget.date, toCompare: 1, dateType: dateType);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 24),
                  const Text(
                    '날짜 계산기',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.black,
                    visualDensity: VisualDensity.compact,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// 계산 방식
              Row(
                children: [
                  const Text(
                    '계산 방식',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        dateType = DateType.dDay;
                        if (int.tryParse(_controller.text) != null) {
                          calculatedDate = calculateDate(
                            date: widget.date,
                            toCompare: int.parse(_controller.text),
                            dateType: dateType,
                          );
                        }
                      });
                    },
                    child: Container(
                      height: 32,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: dateType == DateType.dDay ? Colors.black : Colors.black26,
                        ),
                      ),
                      child: Text(
                        DateType.dDay.name,
                        style: TextStyle(
                          color: dateType == DateType.dDay ? Colors.black : Colors.black26,
                          fontSize: 16,
                          fontWeight: dateType == DateType.dDay ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        dateType = DateType.anniversary;
                        if (int.tryParse(_controller.text) != null) {
                          calculatedDate = calculateDate(
                            date: widget.date,
                            toCompare: int.parse(_controller.text),
                            dateType: dateType,
                          );
                        }
                      });
                    },
                    child: Container(
                      height: 32,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: dateType == DateType.anniversary ? Colors.black : Colors.black26,
                        ),
                      ),
                      child: Text(
                        DateType.anniversary.name,
                        style: TextStyle(
                          color: dateType == DateType.anniversary ? Colors.black : Colors.black26,
                          fontSize: 16,
                          fontWeight: dateType == DateType.anniversary ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// 기준 날짜
              Row(
                children: [
                  const Text(
                    '기준 날짜',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    DateFormat('yyyy.MM.dd.').format(widget.date),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.pink.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              /// 계산 모드
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (calculationType != CalculationType.byDate) {
                          setState(() {
                            calculationType = CalculationType.byDate;
                          });
                        }
                      },
                      child: Container(
                        height: 42,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: calculationType == CalculationType.byDate ? Colors.grey.shade50 : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                              color: calculationType == CalculationType.byDate ? Colors.black : Colors.black26,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          CalculationType.byDate.name,
                          style: TextStyle(
                            color: calculationType == CalculationType.byDate ? Colors.black : Colors.black26,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (calculationType != CalculationType.byCount) {
                          setState(() {
                            calculationType = CalculationType.byCount;
                          });
                        }
                      },
                      child: Container(
                        height: 42,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: calculationType == CalculationType.byCount ? Colors.grey.shade50 : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                              color: calculationType == CalculationType.byCount ? Colors.black : Colors.black26,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          CalculationType.byCount.name,
                          style: TextStyle(
                            color: calculationType == CalculationType.byCount ? Colors.black : Colors.black26,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// 날짜로 계산
              if (calculationType == CalculationType.byDate) ...[
                const SizedBox(height: 18),
                CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    selectedDayHighlightColor: Colors.pink,
                    daySplashColor: Colors.transparent,
                  ),
                  value: [comparedDate],
                  onValueChanged: (dates) {
                    setState(() {
                      comparedDate = dates.first;
                    });
                  },
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${DateFormat('yyyy년 M월 d일').format(comparedDate)}은 ',
                      ),
                      TextSpan(
                        text: calculateDifference(
                          date: widget.date,
                          toCompare: comparedDate,
                          dateType: dateType,
                        ),
                        style: const TextStyle(color: Colors.pink),
                      ),
                      TextSpan(
                        text: ' 입니다.',
                      ),
                    ],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
              ]

              /// 일수로 계산
              else ...[
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '기준 날짜로부터 D',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.numberWithOptions(signed: dateType == DateType.dDay),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          isDense: true,
                        ),
                        style: TextStyle(fontSize: 18),
                        onChanged: (value) {
                          final diff = int.tryParse(value);
                          if (diff != null) {
                            setState(() {
                              calculatedDate = calculateDate(
                                date: widget.date,
                                toCompare: diff,
                                dateType: dateType,
                              );
                            });
                          }
                        },
                      ),
                    ),
                    const Text(
                      ' 인 날은',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: calculatedDate,
                        style: const TextStyle(color: Colors.pink),
                      ),
                      TextSpan(
                        text: ' 입니다.',
                      ),
                    ],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
