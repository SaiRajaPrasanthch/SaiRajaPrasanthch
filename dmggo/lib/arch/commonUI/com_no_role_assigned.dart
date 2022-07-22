import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ComNoRoleAssigned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'No Role Assigned.',
              style: tscwbsn_16b,
            ),
          ),
          Center(
            child: Text(
              'Please Contact Admin.',
              style: tscwbsn_16b,
            ),
          ),
        ],
      ),
    );
  }
}
