import 'package:dmggo/arch/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';

class CommonDropdown extends StatelessWidget {
  final List<String> listdata;
  final TextStyle? textStyle;
  final String? strSelectedValue;
  CommonDropdown(
      {Key? key, required this.listdata, this.textStyle, this.strSelectedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h_35,
      child: DropdownButtonFormField(
        onTap: () {},
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: cteal_300,
        ),
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: h_1, horizontal: h_10),
          fillColor: Colors.teal.shade50,
          enabledBorder: OutlineInputBorder(
            borderRadius: brCir_5,
            borderSide: BorderSide(color: cteal_300, width: h_1),
          ),
        ),
        value: strSelectedValue,
        style: textStyle,
        isExpanded: true,
        items: listdata
            .map((value) => DropdownMenuItem(
                  child: Text(value),
                  value: value,
                ))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }
}
