import 'package:camera/camera.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermissions with ChangeNotifier {
  CameraController _controller = CameraController(
    cameras[0],
    ResolutionPreset.max,
  );
  CameraController get contoller => _controller;
  XFile? _fileImage;
  XFile? _fileImageLocal;
  XFile get fileImage => _fileImage!;
  set setFile(XFile v) {
    _fileImage = v;
  }

  Future<bool> handleCameraPermission() async {
    PermissionStatus permStatus = await Permission.camera.status;
    if (permStatus.isDenied || permStatus.isPermanentlyDenied || permStatus.isLimited || permStatus.isLimited) {
      PermissionStatus perm = await Permission.photos.request();
      if (perm.isGranted) {
        return true;
      }
      return false;
    } else {
      return true;
    }
  }

  flashChange(FlashMode flash) {
    // if (_controller.value.flashMode == flash.auto) {
    //   _controller.setFlashMode(FlashMode.always);
    // } else if (_controller.value.flashMode == FlashMode.always) {
    //   _controller.setFlashMode(FlashMode.off);
    // } else {
    //   _controller.setFlashMode(FlashMode.auto);
    // }
    _controller.setFlashMode(flash);
    cameraContoller = _controller;
  }

  cameraChange() async {
    if (_controller.description.lensDirection == CameraLensDirection.back) {
      _controller = CameraController(cameras[1], ResolutionPreset.max);
    } else {
      _controller = CameraController(cameras[0], ResolutionPreset.max);
    }
    await _controller.initialize();
    cameraContoller = _controller;
  }

  set cameraContoller(CameraController c) {
    _controller = c;
    notifyListeners();
  }

  intializeCamera() async {
    await _controller.initialize();
    _controller.setFlashMode(FlashMode.auto);
    cameraContoller = _controller;
  }

  takePicture() async {
    if (!_controller.value.isInitialized) {
      // showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (_controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await _controller.takePicture();
      _controller.pausePreview();
      _fileImageLocal = file;
      cameraContoller = _controller;
      return file;
    } on CameraException catch (e) {
      // _showCameraException(e);
      // return null;
    }
  }

  stopCamera() {
    _controller.dispose();
    cameraContoller = _controller;
  }

  retake() {
    _controller.resumePreview();

    intializeCamera();
  }

  userPhoto({required BuildContext context}) {
    setFile = _fileImageLocal!;
    stopCamera();
    exitScreen(context);
  }
}
