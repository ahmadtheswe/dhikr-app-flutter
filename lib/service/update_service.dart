import 'package:flutter/cupertino.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdateService {
  Future<void> checkForUpdate() async {
    try {
      final updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      debugPrint("Update check failed: $e");
    }
  }
}