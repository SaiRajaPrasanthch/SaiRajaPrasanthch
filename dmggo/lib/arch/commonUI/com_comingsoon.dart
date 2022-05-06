import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';

class CommonComingSoon extends StatelessWidget {
  final String strTitle;
  CommonComingSoon({Key? key, required this.strTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: h_0,
        centerTitle: false,
        title: Text(
          strTitle,
          style: grfwbsn_18wh,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              strTitle,
              style: grfwbsn_18b,
            ),
            Text(
              strCommingSoon,
              style: grfwnsn_18b,
            ),
          ],
        ),
      ),
    );
  }
}
