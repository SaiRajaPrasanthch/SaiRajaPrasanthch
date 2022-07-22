import 'package:dmggo/arch/view/camera_page.dart';
import 'package:dmggo/arch/view/change_password_screen.dart';
import 'package:dmggo/arch/view/chat_group_creation_screen.dart';
import 'package:dmggo/arch/view/chat_users_group_screen.dart';
import 'package:dmggo/arch/view/chat_users_screen.dart';
import 'package:dmggo/arch/view/forgetpassword_screen.dart';
import 'package:dmggo/arch/view/launch_loading_screen.dart';
import 'package:dmggo/arch/view/launch_screen.dart';
import 'package:dmggo/arch/view/login_screen.dart';
import 'package:dmggo/arch/view/pre_trip_inspection.dart';
import 'package:flutter/material.dart';

exitScreen(BuildContext context) {
  Navigator.pop(context);
}

Future<void> openUserSelectionForGroupCreation(BuildContext context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatUsersGroupSelection()));
}

openGroupCreation(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatGroupCreation()));
}

launchLoadingScreen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => LaunchLoadingScreen()));
}

launchHomeScreen(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LaunchScreen()), (Route<dynamic> route) => false);
}

launchLoginScreen(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
}

openChatUserScreen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatUsersScreen()));
}

openChangePasswordScreen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
}

launchForgetPasswordScreen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
}

launchInspectionScreen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => PreTripInspection()));
}

launchCamera(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));
}
