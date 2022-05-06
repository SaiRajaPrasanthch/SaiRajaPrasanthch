import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/pre_trip_inspection.dart';
import 'package:flutter/material.dart';

class OdometerReadingScreen extends StatelessWidget {
  const OdometerReadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: h_0,
        centerTitle: false,
        title: Text(
          'Odometer',
          style: grfwbsn_18wh,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(h_10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imgOdometer,
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              Text(
                strOdometerTitle,
                style: grfwnsn_16b,
                textAlign: TextAlign.center,
              ),
              sbh_50w_0,
              Comtextfield(
                strLabelText: 'Enter the odometer reading',
                strHintText: 'Ex: 92,39,191',
              ),
              CommonButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PreTripInspection())),
                color: appColor,
                dWidth: hinf,
                strBtnText: 'Start Inspection',
              )
            ],
          ),
        ),
      )),
    );
  }
}
