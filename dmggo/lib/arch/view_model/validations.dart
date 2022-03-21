import 'package:flutter/material.dart';
import 'package:dmggo/arch/models/validation_model.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_error_string.dart';
import 'package:dmggo/arch/view/driver_home_screen.dart';
import 'package:dmggo/arch/view/driver_onboard_screen.dart';
import 'package:dmggo/arch/view/manager_home_screen.dart';

class Validations extends ChangeNotifier {
  ValidationItem _phoneNumber = ValidationItem(null, null);

  ValidationItem get phoneNumber => _phoneNumber;

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  bool isEmail(String input) =>
      RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
          .hasMatch(input);

  bool get isValid {
    if (_phoneNumber.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool changePhoneNumber(String value) {
    if (value.isEmpty) {
      _phoneNumber = ValidationItem(null, strEmailOrPass);
      return false;
    } else if (isPhone(value)) {
      if (value.length >= 10) {
        _phoneNumber = ValidationItem(value, null);
        return false; //make it true

      } else {
        _phoneNumber = ValidationItem(null, strErrValidPhNo);
        return false;
      }
    } else if (!isEmail(value)) {
      _phoneNumber = ValidationItem(null, strErrValidEmail);
      return false;
    } else if (value != dummyStrDrFirstimEmail &&
        value != dummyStrDriverEmail &&
        value != dummyStrOwnerEmail) {
      _phoneNumber = ValidationItem(null, strEmailOrPassDontExist);
      return false;
    } else {
      if (value.toLowerCase() == dummyStrDrFirstimEmail.toLowerCase()) {
        currentTab.insert(0, DriverOnboardingScreen());
      }
      if (value.toLowerCase() == dummyStrDriverEmail.toLowerCase()) {
        currentTab.insert(0, DriverHomeScreen());
      }
      if (value.toLowerCase() == dummyStrOwnerEmail.toLowerCase()) {
        currentTab.insert(0, ManagerHomeScreen());
      }
      _phoneNumber = ValidationItem(value, null);
    }

    return true;
  }

  bool submit({required String strEmail, required BuildContext context}) {
    if (changePhoneNumber(strEmail)) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
}
