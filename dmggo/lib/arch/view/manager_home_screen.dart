import 'package:dmggo/arch/view/carrier_terminal_selection.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_dropdown.dart';
import 'package:dmggo/arch/commonUI/com_listtile.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';

class ManagerHomeScreen extends StatelessWidget {
  ManagerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: h_0,
          centerTitle: false,
          title: Row(
            children: [
              Icon(Icons.home),
              SizedBox(
                width: h_10,
              ),
              Text(
                strLHome,
                style: tscwbsn_18wh,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            CarrierTerminalSelections(),
            Divider(
              height: h_05,
              color: cgrey_500,
            ),
            listActions(),
          ],
        ));
  }

// header with route and carrier
  Widget header() {
    return Padding(
      padding: EdgeInsets.all(h_5),
      child: SizedBox(
        height: h_50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 3,
                child: CommonDropdown(
                  strSelectedValue: listCarrier[0],
                  listdata: listCarrier,
                  textStyle: tscwbsn_14b,
                )),
            SizedBox(
              width: h_10,
            ),
            Expanded(
                flex: 2,
                child: CommonDropdown(
                  strSelectedValue: listRoute[0],
                  listdata: listRoute,
                  textStyle: tscwnsn_14b,
                ))
          ],
        ),
      ),
    );
  }

// Action items of manager
  Widget listActions() {
    return Expanded(
      flex: 4,
      child: ListView.builder(
          itemCount: listMHS.length,
          itemBuilder: (context, index) {
            return CommonListTile(
              strTitle: listMHS[index].strTitle,
              bTileOnComplete: listMHS[index].bStatus,
              intCount: listMHS[index].intCount,
            );
          }),
    );
  }
}
