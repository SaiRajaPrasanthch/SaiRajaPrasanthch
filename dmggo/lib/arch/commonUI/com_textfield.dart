import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/material.dart';
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
  final ValueChanged<String>? onChanged;
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
      this.iMaxLines,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: cgrey, hintColor: cgrey),
      child: TextField(
        controller: controller,
        textAlign: textAlign ?? TextAlign.start,
        style: textStyle ?? tscwnsn_12b,
        obscureText: obscureText ?? false,
        maxLines: iMaxLines ?? 1,
        decoration: InputDecoration(
          filled: filled ?? true,
          fillColor: fillColor ?? cgrey_50,
          prefixIcon: prefixIcon,
          hintText: strHintText ?? "",
          hintStyle: textStyle ?? tscwnsn_12b,
          border: border,
          labelText: strLabelText ?? "",
          alignLabelWithHint: true,
          errorText: strErrorText,
          focusedBorder: border,
          enabledBorder: border 
         ),
        keyboardType: keyboardType,
        onChanged: onChanged,
      ),
    );
  }
}
