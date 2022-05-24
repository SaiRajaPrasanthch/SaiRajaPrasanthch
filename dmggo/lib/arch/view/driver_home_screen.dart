import 'package:flutter/material.dart';
import 'package:dmggo/arch/commonUI/com_listtile.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';

class DriverHomeScreen extends StatelessWidget {
  DriverHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: h_0,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              strMainMenu,
              style: tscwbsn_18wh,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: listDHS.length,
                itemBuilder: (context, index) {
                  return CommonListTile(
                    strTitle: listDHS[index].strTitle,
                    bTileOnComplete: listDHS[index].bStatus,
                    intCount: listDHS[index].intCount,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
