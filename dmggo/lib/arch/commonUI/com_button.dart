import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';

class CommonButton extends StatelessWidget {
  final Color color;
  final String? strBtnText;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double dWidth;
  CommonButton(
      {Key? key,
      required this.color,
      this.strBtnText,
      this.textStyle,
      this.onPressed,
      required this.dWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dWidth,
      height: h_40,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(rrbr_5)),
        child: Text(
          strBtnText ?? "",
          style: textStyle ?? grfwbsn_14wh,
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
