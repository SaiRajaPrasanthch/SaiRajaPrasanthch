import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';

class Comtextfield extends StatelessWidget {
  final Widget? prefixIcon;
  final bool? filled;
  final bool? obscureText;
  final String? strHintText;
  final String? strLabelText;
  final String? strErrorText;
  final TextStyle? textStyle;
  final Color? fillColor;
  final InputBorder? border;
  final TextAlign? textAlign;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? iMaxLines;

  Comtextfield(
      {Key? key,
      this.prefixIcon,
      this.strErrorText,
      this.strHintText,
      this.obscureText,
      this.filled,
      this.textStyle,
      this.fillColor,
      this.border,
      this.strLabelText,
      this.textAlign,
      this.controller,
      this.keyboardType,
      this.iMaxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle ?? grfwnsn_12b,
      obscureText: obscureText ?? false,
      maxLines: iMaxLines??1,
      decoration: InputDecoration(
        filled: filled ?? true,
        fillColor: fillColor ?? cgrey_50,
        prefixIcon: prefixIcon,
        hintText: strHintText ?? "",
        hintStyle: textStyle ?? grfwnsn_12b,
        border: border ?? oibr_5,
        labelText: strLabelText ?? "",
        alignLabelWithHint: true,
        errorText: strErrorText ?? "",
        focusedBorder: border ?? oibr_5,
      ),
      keyboardType: keyboardType,
      // onChanged: (String value) {
      //   // validation.changePhoneNumber(value);
      // },
    );
  }
}
