import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class AdHelper {
  static Future<String> get bannerAdUnitId async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final isEmulator = !androidInfo.isPhysicalDevice;

      if (isEmulator) {
        return 'ca-app-pub-3940256099942544/9214589741'; // Google test ID for Android banner
      } else {
        return 'ca-app-pub-2281191175356508/4048737823'; // Real AdMob ID
      }
    } else if (Platform.isIOS) {
      final deviceInfo = DeviceInfoPlugin();
      final iosInfo = await deviceInfo.iosInfo;
      final isEmulator = !iosInfo.isPhysicalDevice;

      if (isEmulator) {
        return 'ca-app-pub-3940256099942544/2934735716'; // Google test ID for iOS banner
      } else {
        return 'YOUR_IOS_AD_UNIT_ID';
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
