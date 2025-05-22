import 'package:d_counter/screen/license_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_in_store_app_version_checker/flutter_in_store_app_version_checker.dart';
import 'package:store_redirect/store_redirect.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  String currentVersion = '-';
  String newVersion = '-';
  bool isUpdateAvailable = false;

  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  Future<void> checkVersion() async {
    final result = await InStoreAppVersionChecker().checkUpdate();

    setState(() {
      currentVersion = result.currentVersion;
      newVersion = result.newVersion ?? '-';
      isUpdateAvailable = result.canUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              // TODO: 앱 아이콘 추가
              SizedBox(
                width: 120,
                height: 120,
                child: Placeholder(),
              ),
              const SizedBox(height: 28),
              // TODO: 앱 이름 추가
              const Text(
                '앱 이름',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '현재 버전: $currentVersion',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '최신 버전: $newVersion',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: isUpdateAvailable ? Colors.pink.shade200 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (isUpdateAvailable) {
                      StoreRedirect.redirect();
                    }
                  },
                  child: Text(
                    '최신 버전 설치하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Divider(indent: 20, endIndent: 20, height: 30),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LicenseList(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '오픈소스 라이선스',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
