import 'package:d_counter/main.dart';
import 'package:d_counter/screen/date_page.dart';
import 'package:d_counter/screen/initial_page.dart';
import 'package:d_counter/screen/setting_page.dart';
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
  int background = 0;
  int font = 0;

  @override
  void initState() {
    super.initState();
    _fetchPrefs();
  }

  void _fetchPrefs() {
    prefsWithCache.then((prefs) {
      setState(() {
        type = DateType.values[prefs.getInt('dateType') ?? 0];
        name = prefs.getString('dateName');
        dday = DateTime.tryParse(prefs.getString('dateDate') ?? '');
        background = prefs.getInt('backgroundImage') ?? 0;
        font = prefs.getInt('fontFamily') ?? 0;
      });
    });
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
              background: background,
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
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
