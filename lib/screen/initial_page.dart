import 'package:d_counter/screen/setting_page.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  final VoidCallback onSave;

  const InitialPage({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingPage(
              onSave: onSave,
            ),
          ),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            Icon(Icons.add),
            const Text(
              '기억할 날짜를 설정해보세요.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
