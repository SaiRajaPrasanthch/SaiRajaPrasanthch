import 'package:dmggo/arch/commonUI/com_alert.dart';
import 'package:dmggo/arch/models/validation_model.dart';
import 'package:dmggo/arch/repo/api_status.dart';
import 'package:dmggo/arch/repo/user_services.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_error_string.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/utils/urls.dart';
import 'package:flutter/material.dart';

class ChangePasswordLog with ChangeNotifier {
  String? emailOrPassword;
  ChangePasswordLog({this.emailOrPassword});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ValidationItem _validOld = ValidationItem(null, null);

  ValidationItem get validOld => _validOld;
  bool validateOldPass(String value) {
    if (value.isEmpty || value == '') {
      _validOld = ValidationItem(null, strPleaseEnterPass);
      return false;
    } else if (value.length < 6) {
      _validOld = ValidationItem(null, strPleaseEnter6Character);
      return false;
    }
    _validOld = ValidationItem(value, null);
    return true;
  }

  ValidationItem _validNew = ValidationItem(null, null);

  ValidationItem get validNew => _validNew;
  bool validateNewPass(String value, String oldPass) {
    if (value.isEmpty || value == '') {
      _validNew = ValidationItem(null, strPleaseEnterPass);
      return false;
    } else if (value.length < 6) {
      _validNew = ValidationItem(null, strPleaseEnter6Character);
      return false;
    } else if (value == oldPass) {
      _validNew = ValidationItem(null, strSamePasswords);
      return false;
    }
    _validNew = ValidationItem(value, null);
    return true;
  }

  ValidationItem _validConfrm = ValidationItem(null, null);

  ValidationItem get validConfrm => _validConfrm;
  bool validateConfirmPass({String? value, String? strNew, String? oldPass}) {
    if (value!.isEmpty || value == '') {
      _validConfrm = ValidationItem(null, strPleaseEnterPass);
      return false;
    } else if (value.length < 6) {
      _validConfrm = ValidationItem(null, strPleaseEnter6Character);
      return false;
    } else if (value != strNew) {
      _validConfrm = ValidationItem(null, strNewPassDontMatch);
      return false;
    } else if (value == oldPass) {
      _validConfrm = ValidationItem(null, strSamePasswordsConfm);
      return false;
    }
    _validConfrm = ValidationItem(value, null);

    return true;
  }

  api(BuildContext con) async {
    loading = true;
    var res = await UserInfo().postChangePass(strLUrl: URL_POST_CHNAGEPASSWORD, emailOrPhone: emailOrPassword, password: validConfrm.value, oldPassword: validOld.value);
    loading = false;
    if (res is Success) {
      if (res.code == newUserResponse) {
        //Imvalid Old password
        ComAlert().showSuccessAlert(con, res);
        _validOld = ValidationItem(null, strPleaseEnterPass);
      } else if (res.code == successResponse) {
        ComAlert().showSuccessAlert(con, res);
        Future.delayed(Duration(seconds: 2), () {
          exitScreen(con);
          backClick(con);
        });
      } else {
        ComAlert().showSuccessAlert(con, res);
        _validOld = ValidationItem(null, strPleaseEnterPass);
        _validNew = ValidationItem(null, strPleaseEnterPass);
        _validConfrm = ValidationItem(null, strPleaseEnterPass);
      }
    } else {
      ComAlert().showFailureAlert(con, res as Faliure);
      _validOld = ValidationItem(null, strPleaseEnterPass);
      _validNew = ValidationItem(null, strPleaseEnterPass);
      _validConfrm = ValidationItem(null, strPleaseEnterPass);
    }
  }

  backClick(BuildContext con) {
    _validOld = ValidationItem(null, null);
    _validNew = ValidationItem(null, null);
    _validConfrm = ValidationItem(null, null);
    loading = false;
    exitScreen(con);
  }

  validatePasswords({required String strOld, required String strNew, required String strConfrm, required BuildContext context}) async {
    bool isOld = validateOldPass(strOld);

    bool isNew = validateNewPass(strNew, strOld);

    bool isConfrmPass = validateConfirmPass(strNew: strNew, value: strConfrm, oldPass: strOld);
    if (isOld && isNew && isConfrmPass) {
      await api(context);

      return true;
    }
    loading = false;
    return false;
  }
}
