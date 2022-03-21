import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_camera_bottomsheet.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonPhotoview extends StatelessWidget {
  final String strIamgeName;
  CommonPhotoview({Key? key, required this.strIamgeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(h_5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: cwhite,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      strIamgeName,
                      height: screenHeight,
                      width: screenWidth,
                    ),
                    listPhotos()
                  ],
                ),
              ),
              textfield(context)
            ],
          ),
        ));
  }

  Widget listPhotos() {
    return Positioned(
      bottom: h_10,
      child: Container(
        width: screenWidth,
        height: h_200,
        color: cblack38,
        child: Padding(
          padding: EdgeInsets.all(h_5),
          child: Column(
            children: [
              Text(
                strHeaderBS,
                style: grfwbsn_12wh,
              ),
              Padding(
                padding: EdgeInsets.all(h_5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonButton(
                      color: appColor,
                      dWidth: screenWidth! / h_5,
                      strBtnText: strLeft,
                    ),
                    CommonButton(
                      color: ctransparent,
                      dWidth: screenWidth! / h_3,
                      strBtnText: strRight,
                    ),
                    CommonButton(
                      color: ctransparent,
                      dWidth: screenWidth! / h_5,
                      strBtnText: strFront,
                    ),
                    CommonButton(
                      color: ctransparent,
                      dWidth: screenWidth! / h_5,
                      strBtnText: strBack,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: i_4,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listPTIP.length + i_1,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(h_5),
                        child: listPTIP.length != index
                            ? Container(
                                width: screenWidth! / h_5,
                                decoration: BoxDecoration(
                                    borderRadius: brCir_10,
                                    border: Border.all(
                                        width: h_4,
                                        color: strIamgeName ==
                                                listPTIP[index].strImage
                                            ? cblue
                                            : ctransparent)),
                                child: Image.asset(
                                  listPTIP[index].strImage,
                                  width: screenWidth! / h_5,
                                  height: h_100,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) =>
                                          CommonCameraBottomSheet());
                                },
                                child: Container(
                                  width: screenWidth! / h_5,
                                  decoration: BoxDecoration(
                                      borderRadius: brCir_10,
                                      border: Border.all(
                                          width: h_4, color: cwhite)),
                                  child: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: cwhite,
                                  ),
                                ),
                              ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textfield(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(h_5),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: brCir_20,
              child: Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    sbh_5w_5,
                    sbh_5w_5,
                    Expanded(
                      child: TextField(
                        maxLines: i_4,
                        minLines: i_1,
                        decoration: InputDecoration(
                          hintText: strTypeMsg,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    sbh_5w_5,
                    sbh_5w_5,
                    Icon(Icons.attach_file,
                        size: h_30, color: Theme.of(context).hintColor),
                    sbh_5w_5,
                  ],
                ),
              ),
            ),
          ),
          sbh_5w_5,
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              child: Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
