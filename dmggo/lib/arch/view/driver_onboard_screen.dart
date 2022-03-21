import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_listtile.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';

class DriverOnboardingScreen extends StatelessWidget {
  DriverOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          strDrOBS,
          style: grfwbsn_18wh,
        ),
      ),
      body: Column(
        children: [
          header(),
          Padding(
            padding: EdgeInsets.all(h_10),
            child: Text(
              strWelcomeMSG,
              style: grfwnsn_18b,
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            height: h_05,
            color: cgrey_500,
          ),
          driverOnBoardingSteps()
        ],
      ),
    );
  }

// Driver On Boarding Steps Header
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

// Driver On Boarding Steps
  Widget driverOnBoardingSteps() {
    return Expanded(
      flex: 4,
      child: ListView.builder(
          itemCount: listDrOBS.length,
          itemBuilder: (context, index) {
            return CommonListTile(
              strTitle: listDrOBS[index].strTitle,
              bTileOnComplete: listDrOBS[index].bStatus,
              intCount: listDrOBS[index].intCount,
            );
          }),
    );
  }
}
