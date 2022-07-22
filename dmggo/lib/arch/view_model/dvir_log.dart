import 'package:dmggo/arch/models/validation_model.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DVIRLog with ChangeNotifier {
  ValidationItem _validVehicle = ValidationItem(null, null);

  ValidationItem get validVehicle => _validVehicle;

  TextEditingController _textVehicleNumber = TextEditingController();

  TextEditingController get textVehicleNumber => _textVehicleNumber;

  String _scanBarcode = '';

  String get scanBarCode => _scanBarcode;

  set vehicleNumber(String value) {
    _textVehicleNumber.text = value;
    notifyListeners();
  }

  set barCode(String value) {
    _scanBarcode = value;
    vehicleNumber = value;
  }

  scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      if (kDebugMode) {
        print(barcodeScanRes);
      }
      if (barcodeScanRes != '-1' && barcodeScanRes.contains('DMGgo Vehicle : ')) {
        barCode = barcodeScanRes.split(' : ')[i_1];
      } else {
        barCode = '';
        Fluttertoast.showToast(msg: 'No data from QR code.');
      }
    } on PlatformException {
      Fluttertoast.showToast(msg: 'Unable to fetch data');
    }
  }

  startInspection({required BuildContext context}) {
    launchInspectionScreen(context);
  }
}
