import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/permissions.dart/camera_permission_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InspectionLog with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set stepperIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  openCamera({required BuildContext con}) async {
    try {
      if (kDebugMode) {
        print(await CameraPermissions().handleCameraPermission());
      }
      if (await CameraPermissions().handleCameraPermission()) {
        launchCamera(con);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
