import 'package:flutter/material.dart';
import 'package:d_counter/oss_licenses.dart';

import 'license_detail.dart';

class LicenseList extends StatelessWidget {
  const LicenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '오픈소스 라이선스',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ListView.separated(
        itemCount: allDependencies.length,
        itemBuilder: (context, index) {
          final dependency = allDependencies[index];
          return ListTile(
            title: Text(
              '${dependency.name} ${dependency.version}',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LicenseDetail(
                    package: dependency,
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}
