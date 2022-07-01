import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_loader.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view_model/changepass_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  TextEditingController txtOldPass = TextEditingController();
  TextEditingController txtNewPass = TextEditingController();
  TextEditingController txtConfPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ChangePasswordLog _changePasswordLog = context.watch<ChangePasswordLog>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(h_20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      imgChangePassword,
                      height: h_200,
                      width: h_200,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h_10),
                      child: Text(
                        strChangePassword,
                        style: tscw400sn_25b,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: h_40,
                      ),
                      child: Text(
                        strSubChangePass,
                        style: tscwnsn_16b,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h_10, left: h_20, right: h_20),
                      child: oldPass(context: context, validation: _changePasswordLog),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h_10, left: h_20, right: h_20),
                      child: newPass(context: context, validation: _changePasswordLog),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h_10, left: h_20, right: h_20),
                      child: confirmPass(context: context, validation: _changePasswordLog),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h_20, left: h_20, right: h_20),
                      child: btnChangePassword(context: context, validation: _changePasswordLog),
                    ),
                    btnBack(context: context, validation: _changePasswordLog)
                  ],
                ),
              ),
            ),
          ),
          if (_changePasswordLog.isLoading) ComLoader()
        ],
      )),
    );
  }

  Widget oldPass({required BuildContext context, required ChangePasswordLog validation}) {
    return Comtextfield(
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
      strErrorText: validation.validOld.error,
      strLabelText: strOldPassword,
      strHintText: strOldPassword,
      border: oibr_5,
      controller: txtOldPass,
      errorBorder: oibr_5,
      focusBorder: oibr_5,
    );
  }

  Widget newPass({required BuildContext context, required ChangePasswordLog validation}) {
    return Comtextfield(
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
      strErrorText: validation.validNew.error,
      strLabelText: strNewPassword,
      strHintText: strNewPassword,
      border: oibr_5,
      controller: txtNewPass,
      errorBorder: oibr_5,
      focusBorder: oibr_5,
    );
  }

  Widget confirmPass({required BuildContext context, required ChangePasswordLog validation}) {
    return Comtextfield(
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
      strErrorText: validation.validConfrm.error,
      strLabelText: strConfirmPassword,
      strHintText: strConfirmPassword,
      border: oibr_5,
      controller: txtConfPass,
      errorBorder: oibr_5,
      focusBorder: oibr_5,
    );
  }

// login button
  Widget btnChangePassword({required BuildContext context, required ChangePasswordLog validation}) {
    return CommonButton(
        color: appColor,
        strBtnText: strChangePassword,
        textStyle: tscwbsn_14wh,
        dWidth: hinf,
        onPressed: () async {
          if (await validation.validatePasswords(strConfrm: txtConfPass.text, strNew: txtNewPass.text, strOld: txtOldPass.text, context: context)) {
            // launchHomeScreen(context);
          }
        });
  }

  Widget btnBack({required BuildContext context, required ChangePasswordLog validation}) {
    return CommonButton(
        color: ctransparent,
        strBtnText: strBack,
        textStyle: tscwbsndul_14blu,
        dWidth: hinf,
        onPressed: () async {
          validation.backClick(context);
        });
  }
}
