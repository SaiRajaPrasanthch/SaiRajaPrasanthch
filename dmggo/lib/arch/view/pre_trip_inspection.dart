import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_pre_trip_ins_expansiontile.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:flutter/material.dart';

class PreTripInspection extends StatelessWidget {
  PreTripInspection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: h_0,
        centerTitle: false,
        title: Text(
          strPreTI,
          style: grfwbsn_18wh,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [header(), qrScanner(), newDamage(), sbh_10w_0, submit()],
        ),
      ),
    );
  }

// header for carrier and route
  Widget header() {
    return Padding(
      padding: EdgeInsets.all(h_10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            imgCarrierLogo,
            height: h_40,
            width: h_40,
          ),
          Text(
            dStrCarrier,
            style: grfwbsn_18b,
            textAlign: TextAlign.center,
          ),
          Text(
            '- ' + dStrRoute,
            style: grfwnsn_16b,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

// Qr code Scanner to scan vehicle details
  Widget qrScanner() {
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.only(left: h_40, bottom: h_10, top: h_10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: rrbr_50,
              elevation: h_5,
              child: Padding(
                padding: EdgeInsets.all(h_20),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: h_40,
                  color: Colors.blue,
                ),
              ),
            ),
            Column(children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: h_15),
                    child: Text(
                      strVehicle,
                      style: grfwnsn_18b,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: h_15),
                    child: Text(
                      strVNo,
                      style: grfwbsn_18b,
                    ),
                  ),
                ],
              ),
              sbh_10w_0,
              Row(
                children: [
                  Text(
                    strOdometer,
                    style: grfwnsn_18do,
                  ),
                  Text(
                    strOdNo,
                    style: grfwbsn_18do,
                  ),
                ],
              )
            ])
          ],
        ),
      ),
    );
  }

// pre trip inspection defects list
  Widget listOfdefects() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listPTIS.length,
        itemBuilder: (context, index) {
          return CommonPreTripListTile(
            strTitle: listPTIS[index].strTitle,
            strSubTitle: listPTIS[index].strSubTitle,
            isavail: listPTIS[index].isCheck,
            check: listPTIS[index].check,
            strStatus: listPTIS[index].strStatus,
            strImage: listPTIS[index].strImage,
          );
        });
  }

  Widget newDamage() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            listOfdefects(),
            Divider(
              height: h_01,
            ),
            SizedBox(
              height: h_50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Damage",
                    style: grfwbsn_18b,
                  ),
                ],
              ),
            ),
            Divider(
              height: h_01,
            ),
            listOfNewdefects(),
          ],
        ),
      ),
    );
  }

  Widget listOfNewdefects() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listNewDamage.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CommonPreTripListTile(
            strTitle: listNewDamage[index].strTitle,
            strSubTitle: listNewDamage[index].strSubTitle,
            isavail: listNewDamage[index].isCheck,
            check: listNewDamage[index].check,
            strStatus: listNewDamage[index].strStatus,
            strImage: listNewDamage[index].strImage,
          );
        });
  }

// submit button
  Widget submit() {
    return CommonButton(
      color: appColor,
      strBtnText: strSubmit,
      dWidth: h_100,
    );
  }
}
