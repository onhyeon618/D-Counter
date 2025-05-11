import 'package:d_counter/screen/date_page.dart';
import 'package:d_counter/screen/initial_page.dart';
import 'package:flutter/material.dart';

class DCounterHome extends StatefulWidget {
  const DCounterHome({super.key});

  @override
  State<DCounterHome> createState() => _DCounterHomeState();
}

class _DCounterHomeState extends State<DCounterHome> {
  DateTime? dday = DateTime(2025, 1, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dday == null ? InitialPage() : DatePage(),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        child: Container(
          height: 56,
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
                onPressed: () {},
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      )
    );
  }
}
