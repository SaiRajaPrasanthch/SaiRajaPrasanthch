import 'package:dmggo/arch/commonUI/com_camera_bottomsheet.dart';
import 'package:dmggo/arch/commonUI/com_photoview.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/models/pretrip_inspection_model.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view/pretripinspec_popup.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CommonPreTripListTile extends StatelessWidget {
  final String strTitle;
  final bool? isavail;
  final String? strSubTitle;
  final Check check;
  final String? strStatus;
  final String? strImage;
  CommonPreTripListTile({Key? key, required this.strTitle, required this.strSubTitle, this.isavail, this.strStatus, this.strImage, required this.check}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          onExpansionChanged: isavail == null || isavail! ? null : (value) {},
          childrenPadding: EdgeInsets.only(left: h_20, right: h_10, top: h_5, bottom: h_5),
          children: [
            if (strImage != null) listPhotoDisplay(e: strImage, context: context),
            if (strStatus == strDefective || strStatus == strDamageFound) listAddIamge(context: context),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: i_6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(h_5),
                      child: Text(strTitle, style: grfwbsn_18b),
                    ),
                    Padding(
                      padding: EdgeInsets.all(h_5),
                      child: Text(
                        strSubTitle!,
                        style: grfwnsn_16b,
                        maxLines: i_1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: i_2,
                child: Column(
                  children: [
                    speedDialWidget(context),
                    Text(strStatus!, style: grfwnsn_10b),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          height: h_05,
          color: cgrey_900,
        )
      ],
    );
  }

// expanded button for pass or fail the inspection
  Widget speedDialWidget(BuildContext context) {
    return SpeedDial(
      iconTheme: IconThemeData(color: cwhite, size: h_40),
      icon: isavail == null
          ? Icons.more_horiz_rounded
          : isavail!
              ? Icons.check_rounded
              : Icons.close_rounded,
      buttonSize: Size(h_35, h_35),
      backgroundColor: isavail == null
          ? cblue
          : isavail!
              ? cgreen
              : cred,
      activeBackgroundColor: cblue,
      gradientBoxShape: BoxShape.circle,
      spacing: h_4,
      elevation: h_0,
      childrenButtonSize: Size(h_40, h_40),
   
      direction: SpeedDialDirection.up,
      children: [
        SpeedDialChild(
          child: Icon(
            Icons.check_rounded,
            color: cwhite,
            size: h_20,
          ),
          backgroundColor: cgreen,
          label: check.strPass,
        ),
        SpeedDialChild(
            child: Icon(
              Icons.close_rounded,
              color: cwhite,
              size: h_20,
            ),
            backgroundColor: cred,
            label: check.strFail,
            onTap: () => showDialog(context: context, builder: (_) => CommonPreTripInspectPopup(strTitle: strTitle))),
      ],
    );
  }

// showing list of photos uploaded by driver in pre trip inspection
  Widget listPhotoDisplay({String? e, required BuildContext context}) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CommonPhotoview(strIamgeName: e!))),
      child: Padding(
        padding: EdgeInsets.all(h_2),
        child: Container(
          height: h_50,
          decoration: BoxDecoration(
            borderRadius: brCir_10,
            color: cgrey_300,
          ),
          child: Padding(
            padding: EdgeInsets.all(h_4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: i_2,
                  child: Padding(
                    padding: EdgeInsets.all(h_5),
                    child: ClipRRect(
                      borderRadius: brCir_5,
                      child: Image.asset(
                        e!,
                        height: h_30,
                        width: h_10,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                sbh_5w_5,
                Expanded(
                  flex: i_8,
                  child: sbh_5w_5,
                 
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: cred,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listAddIamge({required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(context: context, builder: (context) => CommonCameraBottomSheet());
      },
      child: Padding(
        padding: EdgeInsets.all(h_2),
        child: Container(
          height: h_50,
          decoration: BoxDecoration(
            borderRadius: brCir_10,
            color: cgrey_300,
          ),
          child: Padding(
            padding: EdgeInsets.all(h_4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: i_2,
                  child: Padding(
                    padding: EdgeInsets.all(h_5),
                    child: ClipRRect(
                        borderRadius: brCir_5,
                        child: Icon(
                          Icons.image_outlined,
                          size: h_30,
                          color: cgrey_500,
                        )),
                  ),
                ),
                sbh_5w_5,
                Expanded(
                  flex: i_8,
                  child: Text(
                    strAddImage,
                    style: grfwnsn_14gy500,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: cred,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
