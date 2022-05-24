import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';

class CommonButton extends StatelessWidget {
  final Color color;
  final String strBtnText;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double dWidth;
  final bool? isImage;
  final String? strImage;
  CommonButton({Key? key, required this.color, required this.strBtnText, this.textStyle, this.onPressed, required this.dWidth, this.isImage = false, this.strImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dWidth,
      height: h_40,
      child: ElevatedButton(
        style:
            ButtonStyle(elevation: MaterialStateProperty.all<double>(h_0), backgroundColor: MaterialStateProperty.all<Color>(color), shape: MaterialStateProperty.all<RoundedRectangleBorder>(rrbr_5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isImage!)
              Image.asset(
                strImage!,
                height: 25,
              ),
            Text(
              strBtnText.toUpperCase(),
              style: textStyle ?? tscwbsn_14wh,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
