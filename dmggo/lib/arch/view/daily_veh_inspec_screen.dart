import 'package:dmggo/arch/commonUI/com_listtile.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:flutter/material.dart';

class DailyVehicleInspectionScreen extends StatelessWidget {
  DailyVehicleInspectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: h_0,
        centerTitle: false,
        title: Text(
          strDVI,
          style: grfwbsn_18wh,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: listDVI.length,
                itemBuilder: (context, index) {
                  return CommonListTile(
                    strTitle: listDVI[index].strTitle,
                    bTileOnComplete: listDVI[index].bStatus,
                    intCount: listDVI[index].intCount,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
