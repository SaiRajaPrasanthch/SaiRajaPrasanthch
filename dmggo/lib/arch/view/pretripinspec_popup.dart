import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_camera_bottomsheet.dart';
import 'package:dmggo/arch/commonUI/com_photoview.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonPreTripInspectPopup extends StatelessWidget {
  final String strTitle;

  CommonPreTripInspectPopup({Key? key, required this.strTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        strTitle,
        style: grfwbsn_16b,
      ),
      shape: rrbr_10,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              strPTIPSubTitle,
              style: grfwnsn_16b,
            ),
            photoGridView(),
            TextFormField(
              decoration:
                  InputDecoration(labelText: strADHere, hintText: strADHere),
              style: grfwnsn_12gy,
            )
          ],
        ),
      ),
      actions: [cancelButton(context), submitButton(context)],
    );
  }

//Popup cancel Button
  Widget cancelButton(BuildContext context) {
    return CommonButton(
      color: cgrey_500,
      dWidth: h_100,
      strBtnText: strCancel.toLowerCase(),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

//Popup Submit Button
  Widget submitButton(BuildContext context) {
    return CommonButton(
      color: appColor,
      dWidth: h_100,
      strBtnText: strSubmit.toLowerCase(),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

//Showing selected Photos in a grid view with one grid for photo pick options and has gesture on each photo will navigate to photoview page
  Widget photoGridView() {
    return SizedBox(
      width: 250,
      height: 250,
      child: GridView.builder(
        itemCount: listPTIP.length + i_1,
        shrinkWrap: false,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return index == listPTIP.length
              ? GestureDetector(
                  onTap: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CommonCameraBottomSheet()),
                  child: Card(
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                )
              : Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommonPhotoview(
                                  strIamgeName: listPTIP[index].strImage))),
                      child: photoCardView(index),
                    ),
                    Positioned(
                        right: -h_20,
                        top: -h_15,
                        child: IconButton(
                            onPressed: () {},
                            color: cblue,
                            icon: Icon(
                              Icons.delete_forever_rounded,
                              color: cred,
                            ))),
                  ],
                );
        },
      ),
    );
  }

// Photo Card view
  Widget photoCardView(int index) {
    return Card(
      elevation: h_5,
      child: SizedBox(
        height: h_100,
        width: h_100,
        child: Column(
          children: [
            Image.asset(
              listPTIP[index].strImage,
              height: h_60,
              width: h_60,
            ),
            Text(
              listPTIP[index].strDescription,
              style: grfwnsn_8b,
            )
          ],
        ),
      ),
    );
  }
}
