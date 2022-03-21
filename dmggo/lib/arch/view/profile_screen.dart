import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          strLProfile,
          style: grfwbsn_18wh,
        ),
      ),
      body: Center(
        child: Text(
          strLProfile + ' ' + strCommingSoon,
          style: grfwbsn_18b,
        ),
      ),
    );
  }
}
