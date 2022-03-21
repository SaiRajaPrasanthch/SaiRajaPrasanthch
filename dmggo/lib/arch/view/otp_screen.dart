import 'package:dmggo/arch/view_model/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_resendbtn.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/launch_screen.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);

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
                  child: Image.asset(
                    imgOtpBanner,
                    height: 200,
                    width: 200,
                  ),
                ),
                sbh_20w_0,
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child:
                          inWidgets(context: context, validation: validation)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// child widgets
  Widget inWidgets(
      {required BuildContext context, required Validations validation}) {
    return Column(
      children: [
        sbh_20w_0,
        Text(
          strVerification,
          style: grfwbsn_20b,
        ),
        Text(
          strVerificationText,
          style: grfwnsn_14b,
        ),
        sbh_50w_0,
        otp(context: context, validation: validation),
        resend(),
        sbh_20w_0,
        verify(context: context, validation: validation),
        sbh_20w_0,
      ],
    );
  }

// otp textformfield
  Widget otp({required BuildContext context, required Validations validation}) {
    return Comtextfield(
      textAlign: TextAlign.center,
      obscureText: true,
      textStyle: grfwbsn_16bls20,
      strHintText: "......",
      strErrorText: validation.phoneNumber.error,
    );
  }

// verify button
  Widget verify(
      {required BuildContext context, required Validations validation}) {
    return CommonButton(
      color: Colors.deepOrange,
      strBtnText: strVerifyText,
      textStyle: grfwbsn_14wh,
      dWidth: hinf,
      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LaunchScreen()),
          (Route<dynamic> route) => false),
    );
  }

// resend button
  Widget resend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Text(
            strDROTP,
            style: grfwnsn_14b,
          ),
        ),
        Flexible(child: ResendOTP())
      ],
    );
  }
}
