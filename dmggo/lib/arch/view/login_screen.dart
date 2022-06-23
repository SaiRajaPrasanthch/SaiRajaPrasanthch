import 'package:dmggo/arch/commonUI/com_loader.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController txtEmailCont = TextEditingController();
  final TextEditingController txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Validations validation = context.watch<Validations>();
    // txtEmailCont.text = dummyStrOwnerEmail;
    return Scaffold(
      backgroundColor: cgrey_200,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: h_30, right: h_30),
                      child: Image.asset(imgLogoBanner),
                    ),
                    sbh_20w_0,
                    Padding(
                      padding: EdgeInsets.only(left: h_20, right: h_20),
                      child: Card(
                        shape: rrbr_20,
                        child: Padding(padding: EdgeInsets.only(left: h_20, right: h_20), child: incardWidget(context: context, validation: validation)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (validation.isLoading) ComLoader(),
        ],
      ),
    );
  }

// card child widgets
  Widget incardWidget({required BuildContext context, required Validations validation}) {
    return Column(
      children: [
        sbh_20w_0,
        Text(
          strLoginTitle,
          style: tscwbsn_20b,
        ),
        sbh_30w_0,
        Padding(
          padding: EdgeInsets.only(bottom: h_10),
          child: email(context: context, validation: validation),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: h_10),
          child: pass(context: context, validation: validation),
        ),
        login(context: context, validation: validation),
        sbh_5w_0,
        forgetpass(context: context),
        sbh_5w_0,
        Divider(),
        sbh_5w_0,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: strLoginWithDMGgo1),
              TextSpan(text: '\n' + strLoginWithDMGgo2 + '\n'),
              TextSpan(text: strLoginWithDMGgo3),
            ],
            style: tscwnsn_14b,
          ),
          textAlign: TextAlign.center,
        ),
        // Text(
        //   strLoginWithDMGgo,
        //   style: tscwnsn_14b,
        // ),
        sbh_20w_0,
        signup(context: context),
        sbh_20w_0,
      ],
    );
  }

// email textformfield
  Widget email({required BuildContext context, required Validations validation}) {
    // txtEmailCont.text = 'prasanth.ch@seanergydigital.com';
    return Comtextfield(
      obscureText: false,
      prefixIcon: Icon(Icons.person),
      strErrorText: validation.validPhoneEmail.error,
      strLabelText: strEmailPhNum,
      strHintText: strEmailPhNum,
      controller: txtEmailCont,
      border: oibr_5,
      errorBorder: oibr_5,
      focusBorder: oibr_5,
      keyboardType: TextInputType.emailAddress,
      // onChanged: (s) => validation.changePhoneNumber(s),
    );
  }

// password textformfield
  Widget pass({required BuildContext context, required Validations validation}) {
    // txtPass.text = '123456';

    return Comtextfield(
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
      strErrorText: validation.validPassword.error,
      strLabelText: strPassword,
      strHintText: strPassword,
      border: oibr_5,
      controller: txtPass,
      errorBorder: oibr_5,
      focusBorder: oibr_5,
    );
  }

// login button
  Widget login({required BuildContext context, required Validations validation}) {
    return CommonButton(
        color: appColor,
        strBtnText: strLoginTitle,
        textStyle: tscwbsn_14wh,
        dWidth: hinf,
        onPressed: () async {
          if (await validation.submit(strEmail: txtEmailCont.text, strPass: txtPass.text, context: context)) {
            // launchHomeScreen(context);
          }
        });
  }

//Signup Button
  Widget signup({required BuildContext context}) {
    return CommonButton(
      color: cgrey_200,
      strBtnText: strSignInMicrosoft,
      textStyle: tscwbsn_14b,
      dWidth: hinf,
      isImage: true,
      strImage: imgMicrosoftLogo,
      onPressed: () async {
        // await oauth.login();

        // accessToken = await oauth.getAccessToken();
        // if (accessToken != null) {
        launchLoadingScreen(context);
        // }

        // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
      },
    );
  }

//Forget password Button
  Widget forgetpass({required BuildContext context}) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          strForPass,
          style: tscwnsn_12b,
        ),
        onPressed: () {
          launchForgetPasswordScreen(context);
        },
      ),
    );
  }
}
