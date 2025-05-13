import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // TODO
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
