import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/view/odo_read_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  'assets/images/qr_code.png',
                  height: screenHeight! * 0.75,
                  width: screenWidth,
                ),
                Container(
                  color: Colors.black26,
                  height: screenHeight! * 0.75,
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: DottedBorder(
                        color: appColor,
                        borderType: BorderType.RRect,
                        dashPattern: const [
                          100,
                          100,
                          100,
                          100,
                          150,
                          100,
                          150,
                          100,
                        ],
                        radius: Radius.circular(12),
                        strokeWidth: 5,
                        child: SizedBox(
                          height: 250,
                          width: 250,
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(h_10),
                        child: Text(
                          'Please place the QR code in the box',
                          style: grfwbsn_14wh,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: 100,
                    left: 10,
                    right: 10,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Scan the QR Code on the Vehicle',
                          style: grfwbsn_14wh,
                        ))),
                Positioned(
                    left: 1,
                    top: 40,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_rounded),
                      color: Colors.white,
                    )),
                Positioned(
                    right: 1,
                    top: 40,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.flash_auto),
                      color: Colors.white,
                    )),
              ],
            ),
            Container(
              height: screenHeight! * 0.25,
              color: Colors.white,
              width: screenWidth,
              //  decoration: ,
              child: Padding(
                padding: EdgeInsets.all(h_10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(h_10),
                      child: Text(
                        'Or',
                        style: grfwbsn_16b,
                      ),
                    ),
                    Comtextfield(
                      strLabelText: 'Enter vehicle no manually.....',
                      strHintText: 'Enter vehicle no manually.....',
                    ),
                    CommonButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OdometerReadingScreen())),
                      color: appColor,
                      dWidth: hinf,
                      strBtnText: "Next",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
