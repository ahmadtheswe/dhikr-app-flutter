import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ApplicationVersion extends StatelessWidget {
  const ApplicationVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAppVersion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('App Version: ${snapshot.data}');
        }
      },
    );
  }

  Future<String> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
