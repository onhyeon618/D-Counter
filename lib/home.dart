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
            : DatePage(),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          height: 60,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
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
                SizedBox(width: 8),
              ],
            ),
          ),
        ));
  }
}
