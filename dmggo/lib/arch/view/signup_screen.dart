import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/otp_screen.dart';
import 'package:dmggo/arch/view_model/validations.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController txtEmailCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Validations validation = context.watch<Validations>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                    child: Padding(padding: EdgeInsets.only(left: h_20, right: h_20), child: incardWidget(context: context, validation: validation)),
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
  Widget incardWidget({required BuildContext context, required Validations validation}) {
    return Column(
      children: [
        sbh_20w_0,
        Text(
          strCYLTiile,
          style: tscwbsn_20b,
        ),
        sbh_30w_0,
        email(context: context, validation: validation),
        pass(context: context, validation: validation),
        pass(context: context, validation: validation),
        submit(context: context, validation: validation),
        sbh_20w_0,
      ],
    );
  }

// email textformfield
  Widget email({required BuildContext context, required Validations validation}) {
    return Comtextfield(
      obscureText: false,
      prefixIcon: Icon(Icons.person),
      strErrorText: validation.validPhoneEmail.error,
      strHintText: strEmailPhNum,
      strLabelText: strEmailPhNum,
      controller: txtEmailCont,
    );
  }

// password textformfield
  Widget pass({required BuildContext context, required Validations validation}) {
    return Comtextfield(
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
      // strErrorText: validation.phoneNumber.error,
      strHintText: strPassword,
      strLabelText: strPassword,
    );
  }

  // re-enter password textformfield
  Widget repass({required BuildContext context, required Validations validation}) {
    return Comtextfield(
      obscureText: true,
      prefixIcon: Icon(Icons.lock),
      // strErrorText: validation.phoneNumber.error,
      strHintText: strRePassword,
      strLabelText: strRePassword,
    );
  }

// submit button
  Widget submit({required BuildContext context, required Validations validation}) {
    return CommonButton(
        color: appColor,
        strBtnText: strSubmit,
        textStyle: tscwbsn_14wh,
        dWidth: hinf,
        onPressed: () {
          // if (validation.submit(strEmail: txtEmailCont.text, context: context)) {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen()));
          // }
        });
  }
}
