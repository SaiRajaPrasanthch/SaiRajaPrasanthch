import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';

class CommonAppBar extends StatelessWidget {
  final String strTitle;
  CommonAppBar({Key? key, required this.strTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        strTitle,
        style: grfwbsn_18wh,
      ),
    );
  }
}
