import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/material.dart';

class ComLoader extends StatelessWidget {
  const ComLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: cgrey.withOpacity(0.5),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
