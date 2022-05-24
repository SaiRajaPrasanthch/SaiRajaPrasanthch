import 'package:badges/badges.dart';
import 'package:dmggo/arch/commonUI/com_comingsoon.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/daily_veh_inspec_screen.dart';
import 'package:dmggo/arch/view/driver_clock_punch.dart';
import 'package:dmggo/arch/view/qr_code_screen.dart';
import 'package:dmggo/arch/view/reconciliation_screen.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';

class CommonListTile extends StatelessWidget {
  final String? strTitle;
  final int? intCount;
  final bool bTileOnComplete;
  CommonListTile({Key? key, required this.strTitle, required this.bTileOnComplete, this.intCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => strTitle == strDVI
              ? Navigator.push(context, MaterialPageRoute(builder: (context) => DailyVehicleInspectionScreen()))
              : strTitle == strPreTI
                  ? Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodeScreen()))
                  : strTitle == strReconcilation
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Reconciliation(
                                    strTitle: strTitle!,
                                  )))
                      : strTitle == strMyClockPunches
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DrvierClockPunch(
                                        strTitle: strTitle!,
                                      )))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommonComingSoon(
                                        strTitle: strTitle!,
                                      ))),
          selected: bTileOnComplete,
          selectedTileColor: cgrey_100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                strTitle ?? "",
                style: bTileOnComplete ? tscwnsn_16gy500 : tscwnsn_16b,
              ),
              intCount == null
                  ? sbh_5w_0
                  : Badge(
                      badgeColor: cblue_700,
                      shape: BadgeShape.circle,
                      elevation: h_0,
                      badgeContent: Text(
                        intCount.toString(),
                        style: tscwnsn_16wh,
                      ),
                    ),
            ],
          ),
          trailing: !bTileOnComplete
              ? Icon(Icons.arrow_forward_ios_rounded)
              : Icon(
                  Icons.check_circle,
                  color: cgreen,
                ),
        ),
        Divider(
          height: h_01,
          color: cgrey_900,
        )
      ],
    );
  }
}
