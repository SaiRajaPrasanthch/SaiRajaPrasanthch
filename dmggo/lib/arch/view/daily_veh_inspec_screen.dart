import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_listtile.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view_model/dvir_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyVehicleInspectionScreen extends StatelessWidget {
  DailyVehicleInspectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cwhite,
      appBar: AppBar(
        elevation: h_0,
        centerTitle: false,
        title: Text(
          strDVI,
          style: tscwbsn_18wh,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.separated(
                itemCount: listDVI.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                        childrenPadding: EdgeInsets.only(left: h_25, right: h_25, top: h_5, bottom: 5),
                        children: scandetails(context: context),
                        title: Text(
                          listDVI[index].strTitle,
                        )),
                  );
                }),
          ),
          sbh_20w_0
        ],
      ),
    );
  }

  List<Widget> scandetails({required BuildContext context}) {
    return [
      GestureDetector(
        onTap: (() {
          context.read<DVIRLog>().scanQR();
        }),
        child: Image.asset(
          imgQRCode,
          height: screenHeight! * h_02,
          width: screenHeight! * h_02,
        ),
      ),
      sbh_15w_2,
      Text(
        'Scan the QR code on the vehicle',
        style: tscwbsn_16blu,
      ),
      sbh_10w_0,
      Row(
        children: [
          Expanded(
              flex: 2,
              child: Divider(
                color: cgrey,
              )),
          Expanded(
              flex: 1,
              child: Text(
                'or',
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 2,
              child: Divider(
                color: cgrey,
              ))
        ],
      ),
      sbh_10w_0,
      Text(
        'Manually Enter',
        style: tscwbsn_16blu,
      ),
      sbh_10w_0,
      Row(
        children: [
          Expanded(
            flex: i_8,
            child: Comtextfield(
              strHintText: 'Enter Vehicle Number',
              strLabelText: 'Enter Vehicle Number',
              border: oibr_5,
              controller: context.watch<DVIRLog>().textVehicleNumber,
            ),
          ),
          // Expanded(
          //     flex: i_1,
          //     child: Text(
          //       'or',
          //       style: tscwbsn_16b,
          //       textAlign: TextAlign.right,
          //     )),
          // Expanded(
          //     flex: i_2,
          //     child: Icon(
          //       Icons.qr_code_scanner_rounded,
          //       size: h_40,
          //     ))
        ],
      ),
      sbh_10w_0,
      Row(
        children: [
          Expanded(
            flex: i_3,
            child: GestureDetector(
              onTap: () {},
              child: Comtextfield(
                strHintText: 'Enter Odometer Reading',
                strLabelText: 'Enter Odometer Reading',
                border: oibr_5,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
      sbh_10w_0,
      CommonButton(
        color: appColor,
        strBtnText: 'Start Inspection',
        dWidth: screenWidth!,
        onPressed: () {
          context.read<DVIRLog>().startInspection(context: context);
        },
      )
    ];
  }
}
