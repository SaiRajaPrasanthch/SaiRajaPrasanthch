import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

class ComAlert {
  showSuccessAlert(BuildContext context, Success _object) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (con) {
          return AlertDialog(
            titleTextStyle: tscwbsn_16b,
            clipBehavior: Clip.hardEdge,
            shape: rrbr_10,
            // title: Text(
            //   _object.code.toString(),
            //   textAlign: TextAlign.center,
            // ),
            content: Text(_object.response.toString(), textAlign: TextAlign.center),
            contentTextStyle: tscwnsn_16b,
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              CommonButton(
                color: ctransparent,
                strBtnText: strOK,
                textStyle: tscwbsn_16blu,
                dWidth: hinf,
                onPressed: () => exitScreen(context),
              )
            ],
          );
        });
  }

  showFailureAlert(BuildContext context, Faliure _object) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (con) {
          return AlertDialog(
            titleTextStyle: tscwbsn_16b,
            clipBehavior: Clip.hardEdge,
            shape: rrbr_10,
            // title: Text(
            //   _object.code.toString(),
            //   textAlign: TextAlign.center,
            // ),
            content: Text(_object.errorResponse.toString(), textAlign: TextAlign.center),
            contentTextStyle: tscwnsn_16b,
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              CommonButton(
                color: ctransparent,
                strBtnText: strOK,
                textStyle: tscwbsn_16blu,
                dWidth: hinf,
                onPressed: () => exitScreen(context),
              )
            ],
          );
        });
  }
}
