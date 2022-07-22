import 'package:camera/camera.dart';
import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/permissions.dart/camera_permission_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    super.initState();
    context.read<CameraPermissions>().intializeCamera();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (context.watch<CameraPermissions>().contoller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      context.read<CameraPermissions>().stopCamera();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties

      context.read<CameraPermissions>().intializeCamera();
    }
  }

  @override
  void dispose() {
    CameraPermissions().stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ctransparent,
      body: !context.watch<CameraPermissions>().contoller.value.isInitialized
          ? Container()
          : Stack(
              children: [
                SizedBox(height: screenHeight, width: screenWidth, child: CameraPreview(context.watch<CameraPermissions>().contoller)),
                Padding(
                  padding: EdgeInsets.only(top: h_30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: context.watch<CameraPermissions>().contoller.value.isPreviewPaused
                          ? () {
                              context.read<CameraPermissions>().retake();
                            }
                          : () {
                              exitScreen(context);
                            },
                      icon: Icon(context.watch<CameraPermissions>().contoller.value.isPreviewPaused ? Icons.close_rounded : Icons.arrow_back_rounded),
                      color: cwhite,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    height: screenHeight! * h_02,
                    width: screenWidth,
                    child: context.watch<CameraPermissions>().contoller.value.isPreviewPaused
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CommonButton(
                                  color: ctransparent,
                                  strBtnText: 'retake',
                                  dWidth: screenWidth! * 0.4,
                                  onPressed: () {
                                    context.read<CameraPermissions>().retake();
                                  }),
                              CommonButton(color: ctransparent, strBtnText: 'Use Photo', dWidth: screenWidth! * 0.4),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (context.read<CameraPermissions>().contoller.value.flashMode == FlashMode.auto) {
                                    context.read<CameraPermissions>().flashChange(FlashMode.always);
                                  } else if (context.read<CameraPermissions>().contoller.value.flashMode == FlashMode.always) {
                                    context.read<CameraPermissions>().flashChange(FlashMode.off);
                                  } else {
                                    context.read<CameraPermissions>().flashChange(FlashMode.auto);
                                  }
                                },
                                icon: Icon(context.watch<CameraPermissions>().contoller.value.flashMode == FlashMode.auto
                                    ? Icons.flash_auto_rounded
                                    : context.watch<CameraPermissions>().contoller.value.flashMode == FlashMode.always
                                        ? Icons.flash_on_rounded
                                        : Icons.flash_off_rounded),
                                color: cwhite,
                                iconSize: h_35,
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<CameraPermissions>().takePicture();
                                },
                                icon: Icon(Icons.circle_outlined),
                                color: cwhite,
                                iconSize: h_80,
                              ),
                              // IconButton(
                              //   onPressed: () {
                              //     context.read<CameraPermissions>().cameraChange();
                              //   },
                              //   icon: Icon(Icons.cameraswitch_outlined),
                              //   color: cwhite,
                              //   iconSize: h_35,
                              // ),
                            ],
                          ),
                  ),
                )
              ],
            ),
    );
  }
}
