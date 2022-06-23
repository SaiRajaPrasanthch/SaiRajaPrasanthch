import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.all(h_20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                imgForgetPassword,
                height: h_200,
                width: h_200,
              ),
              Text(
                strForPass,
                style: tscw400sn_25b,
              ),
              Padding(
                padding: EdgeInsets.only(top: h_10, bottom: h_10),
                child: Text(
                  strForPassSub,
                  style: tscwnsn_16b,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: h_10, left: h_20, right: h_20),
                child: email(context: context),
              ),
              Padding(
                padding: EdgeInsets.only(top: h_20, bottom: h_20, left: h_20, right: h_20),
                child: btnChangePassword(
                  context: context,
                ),
              ),
              btnBack(
                context: context,
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget email({required BuildContext context}) {
    return Comtextfield(
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
      // strErrorText: validation.validOld.error,
      strLabelText: strEmailPhNum,
      strHintText: strEmailPhNum,
      border: oibr_5,
      // controller: txtOldPass,
      errorBorder: oibr_5,
      focusBorder: oibr_5,
    );
  }

  Widget btnChangePassword({required BuildContext context}) {
    return CommonButton(
        color: appColor,
        strBtnText: strChangePassword,
        textStyle: tscwbsn_14wh,
        dWidth: hinf,
        onPressed: () async {
          // if (await validation.validatePasswords(strConfrm: txtConfPass.text, strNew: txtNewPass.text, strOld: txtOldPass.text, context: context)) {
          // launchHomeScreen(context);
          // }
        });
  }

  Widget btnBack({
    required BuildContext context,
  }) {
    return CommonButton(
        color: ctransparent,
        strBtnText: strBackToLogin,
        textStyle: tscwbsndul_14blu,
        dWidth: hinf,
        onPressed: () async {
          exitScreen(context);
        });
  }
}
