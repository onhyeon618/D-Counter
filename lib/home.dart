import 'dart:io';

import 'package:d_counter/common/enums.dart';
import 'package:d_counter/common/statics.dart';
import 'package:d_counter/screen/screen.dart';
import 'package:flutter/material.dart';

class DCounterHome extends StatefulWidget {
  const DCounterHome({super.key});

  @override
  State<DCounterHome> createState() => _DCounterHomeState();
}

class _DCounterHomeState extends State<DCounterHome> {
  DateType type = DateType.dDay;
  String? name;
  DateTime? dday;
  int backgroundIndex = 0;
  String customBackground = '';
  int font = 0;

  @override
  void initState() {
    super.initState();
    _fetchPrefs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var idx = 1; idx < 10; idx++) {
      precacheImage(AssetImage('assets/images/background$idx.jpg'), context);
    }
    if (customBackground.isNotEmpty) {
      precacheImage(FileImage(File(customBackground)), context);
    }
  }

  void _fetchPrefs() {
    prefsWithCache.then((prefs) {
      setState(() {
        type = DateType.values[prefs.getInt('dateType') ?? 0];
        name = prefs.getString('dateName');
        dday = DateTime.tryParse(prefs.getString('dateDate') ?? '');
        backgroundIndex = prefs.getInt('backgroundIndex') ?? 0;
        customBackground = prefs.getString('customBackground') ?? '';
        font = prefs.getInt('fontFamily') ?? 0;
      });
    });
  }

  void _openCalculator() {
    DateCalculatorModal.show(
      context: context,
      date: dday!,
      type: type,
    );
  }

  void _openSettingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingPage(
          initialName: name,
          initialDate: dday,
          initialDateType: type,
          initialBackground: backgroundIndex,
          initialCustomImage: customBackground,
          initialFont: font,
          onSave: _fetchPrefs,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dday == null
          ? InitialPage(
              onSave: _fetchPrefs,
            )
          : DatePage(
              date: dday!,
              type: type,
              name: name,
              background: backgroundIndex,
              customBackground: customBackground,
              font: font,
            ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        child: BottomAppBar(
          height: 60,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.calculate_outlined),
                onPressed: dday != null ? _openCalculator : null,
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: dday != null ? _openSettingPage : null,
                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppInfoScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
