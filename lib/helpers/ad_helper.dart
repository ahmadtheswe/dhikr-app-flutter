import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdHelper {
  static Future<String> get bannerAdUnitId async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final isEmulator = !androidInfo.isPhysicalDevice;

      if (isEmulator) {
        return 'ca-app-pub-3940256099942544/9214589741'; // Google test ID for Android banner
      } else {
        return dotenv.env['ANDROID_BANNER_AD_UNIT_ID'] ??
            'ca-app-pub-0000000000000000/0000000000';
      }
    } else if (Platform.isIOS) {
      final deviceInfo = DeviceInfoPlugin();
      final iosInfo = await deviceInfo.iosInfo;
      final isEmulator = !iosInfo.isPhysicalDevice;

      if (isEmulator) {
        return 'ca-app-pub-3940256099942544/2934735716'; // Google test ID for iOS banner
      } else {
        return dotenv.env['IOS_BANNER_AD_UNIT_ID'] ??
            'ca-app-pub-0000000000000000/0000000000';
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
