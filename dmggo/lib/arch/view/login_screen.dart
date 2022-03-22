import 'package:dmggo/arch/view/launch_screen.dart';
import 'package:dmggo/arch/view/signup_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;
    screenHeight ??= MediaQuery.of(context).size.height;
    Validations validation = context.watch<Validations>();
    return Scaffold(
      backgroundColor: cgrey_200,
      body: SafeArea(
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
                    child: Padding(
                        padding: EdgeInsets.only(left: h_20, right: h_20),
                        child: incardWidget(
                            context: context, validation: validation)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// card child widgets
  Widget incardWidget(
      {required BuildContext context, required Validations validation}) {
    return Column(
      children: [
        sbh_20w_0,
        Text(
          strLoginTitle,
          style: grfwbsn_20b,
        ),
        sbh_30w_0,
        email(context: context, validation: validation),
        pass(context: context, validation: validation),
        login(context: context, validation: validation),
        sbh_5w_0,
        forgetpass(context: context),
        sbh_5w_0,
        Divider(),
        sbh_5w_0,
        Text(
          strNewDMGgo,
          style: grfwnsn_16b,
        ),
        sbh_20w_0,
        signup(context: context),
        sbh_20w_0,
      ],
    );
  }

// email textformfield
  Widget email(
      {required BuildContext context, required Validations validation}) {
    return Comtextfield(
      obscureText: false,
      prefixIcon: Icon(Icons.person),
      strErrorText: validation.phoneNumber.error,
      strLabelText: strEmailPhNum,
      strHintText: strEmailPhNum,
      controller: txtEmailCont,
      keyboardType: TextInputType.emailAddress,
    );
  }

// password textformfield
  Widget pass(
      {required BuildContext context, required Validations validation}) {
    return Comtextfield(
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
      // strErrorText: validation.phoneNumber.error,
      strLabelText: strPassword,
      strHintText: strPassword,
    );
  }

// login button
  Widget login(
      {required BuildContext context, required Validations validation}) {
    return CommonButton(
        color: Colors.deepOrange,
        strBtnText: strLoginTitle,
        textStyle: grfwbsn_14wh,
        dWidth: hinf,
        onPressed: () {
          if (validation.submit(
              strEmail: txtEmailCont.text, context: context)) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LaunchScreen()),
                (Route<dynamic> route) => false);
          }
        }
        // () => Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => LaunchScreen()),
        //     (Route<dynamic> route) => false),
        );
  }

//Signup Button
  Widget signup({required BuildContext context}) {
    return CommonButton(
      color: Colors.deepOrange,
      strBtnText: strSignup,
      textStyle: grfwbsn_14wh,
      dWidth: hinf,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupScreen()));
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
          style: grfwnsn_12b,
        ),
        onPressed: () {},
      ),
    );
  }
}