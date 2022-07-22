import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_pre_trip_ins_expansiontile.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/models/pretrip_inspection_model.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view_model/inspection_log.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

class PreTripInspection extends StatelessWidget {
  PreTripInspection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: cgrey_400,
      appBar: AppBar(
        elevation: h_0,
        centerTitle: false,
        title: Text(
          strPreTI,
          style: tscwbsn_18wh,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            header(), qrScanner(),
            Container(
              height: 80,
              color: cwhite,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: myStepper(),
              ),
            ),
            Divider(
              height: h_01,
              color: cblack,
            ),

            subMyStepper(context: context),
            // NumberStepper(enableNextPreviousButtons: false, direction: Axis.horizontal, numbers: const [1, 2, 3, 4, 5, 6])
            // Expanded(child: stepper())
            // newDamage(), sbh_10w_0, submit()
          ],
        ),
      ),
    );
  }

  Widget myStepper() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: listPTIS.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<InspectionLog>().stepperIndex = index;
                },
                child: Container(
                  padding: const EdgeInsets.all(11.0),
                  decoration: BoxDecoration(border: Border.all(color: cgrey_200, width: 5), shape: BoxShape.circle, color: cgrey_400),
                  child: Text(
                    (index + 1).toString(),
                    style: tscwbsn_16wh,
                  ),
                ),
              ),
              if (index + 1 < listPTIS.length)
                SizedBox(
                  width: 60,
                  child: Divider(
                    color: cgrey_200,
                    thickness: 5,
                  ),
                )
            ],
          );
        });
  }

  Widget subMyStepper({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(left: h_10, top: h_10, right: h_10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            listPTIS[context.watch<InspectionLog>().currentIndex].strTitle,
            style: tscwbsn_18b,
          ),
          Text(
            listPTIS[context.watch<InspectionLog>().currentIndex].strSubTitle!,
            style: tscwnsn_18b,
          ),
          sbh_15w_2,
          Center(
            child: CupertinoSegmentedControl(
                unselectedColor: cgrey_100,
                borderColor: cgrey,
                selectedColor: cwhite,
                pressedColor: cwhite,
                children: {
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      listPTIS[context.watch<InspectionLog>().currentIndex].check[0].strPass,
                      style: TextStyle(color: CupertinoColors.black),
                    ),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      listPTIS[context.watch<InspectionLog>().currentIndex].check[1].strPass,
                      style: TextStyle(color: CupertinoColors.black),
                    ),
                  ),
                },
                onValueChanged: (value) {},
                // groupValue: selectedValue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          ),
          Center(
            child: Card(
              child: SizedBox(
                width: screenWidth! * 0.85,
                height: screenHeight! * 0.3,
                child: Column(
                  children: [
                    sbh_10w_0,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: screenWidth! * 0.55,
                        height: screenHeight! * 0.15,
                        decoration: BoxDecoration(border: Border.all(color: cgrey), borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: cgrey_300,
                              size: 50,
                            ),
                            Text(
                              'Click here to capture more',
                              style: tscwnsn_18gy500,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Comtextfield(
                        strLabelText: 'Add description here',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (context.watch<InspectionLog>().currentIndex != 0)
                          CommonButton(
                            color: cwhite,
                            strBtnText: 'previous',
                            textStyle: tscwnsn_14gy500,
                            dWidth: screenWidth! * 0.35,
                          ),
                        CommonButton(
                          color: appColor,
                          strBtnText: 'next',
                          dWidth: screenWidth! * 0.25,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget stepper() {
  //   return Stepper(currentStep: 1, type: StepperType.horizontal, physics: ScrollPhysics(), steps: [
  //     Step(
  //         title: Divider(),
  //         content: Column(
  //           children: [
  //             Text('skjdfnks'),
  //             Text('skjdfnks'),
  //           ],
  //         )),
  //     Step(title: Divider(), content: Text('')),
  //     Step(title: Divider(), content: Text('')),
  //     Step(
  //         title: Divider(
  //           color: Colors.red,
  //         ),
  //         content: Text('')),
  //     Step(title: Divider(), content: Text('')),
  //     // Step(title: Divider(), content: Text('')),
  //     // Step(title: Divider(), content: Text('')),
  //     // Step(title: Divider(), content: Text('')),
  //   ]);
  // }

// header for carrier and route
  Widget header() {
    return Padding(
      padding: EdgeInsets.all(h_10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            imgCarrierLogo,
            height: h_40,
            width: h_40,
          ),
          Text(
            dStrCarrier,
            style: tscwbsn_18b,
            textAlign: TextAlign.center,
          ),
          Text(
            '- ' + dStrRoute,
            style: tscwnsn_16b,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

// Qr code Scanner to scan vehicle details
  Widget qrScanner() {
    return ColoredBox(
      color: cgrey_300,
      child: Padding(
        padding: EdgeInsets.only(left: h_40, bottom: h_10, top: h_10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: rrbr_50,
              elevation: h_5,
              child: Padding(
                padding: EdgeInsets.all(h_20),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: h_40,
                  color: Colors.blue,
                ),
              ),
            ),
            Column(children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: h_15),
                    child: Text(
                      strVehicle,
                      style: tscwnsn_18b,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: h_15),
                    child: Text(
                      strVNo,
                      style: tscwbsn_18b,
                    ),
                  ),
                ],
              ),
              sbh_10w_0,
              Row(
                children: [
                  Text(
                    strOdometer,
                    style: tscwnsn_18do,
                  ),
                  Text(
                    strOdNo,
                    style: tscwbsn_18do,
                  ),
                ],
              )
            ])
          ],
        ),
      ),
    );
  }

// pre trip inspection defects list
  // Widget listOfdefects() {
  //   return ListView.builder(
  //       physics: NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemCount: listPTIS.length,
  //       itemBuilder: (context, index) {
  //         return CommonPreTripListTile(
  //           strTitle: listPTIS[index].strTitle,
  //           strSubTitle: listPTIS[index].strSubTitle,
  //           isavail: listPTIS[index].isCheck,
  //           check: listPTIS[index].check,
  //           strStatus: listPTIS[index].strStatus,
  //           strImage: listPTIS[index].strImage,
  //         );
  //       });
  // }

  // Widget newDamage() {
  //   return Expanded(
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           listOfdefects(),
  //           Divider(
  //             height: h_01,
  //           ),
  //           SizedBox(
  //             height: h_50,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "New Damage",
  //                   style: tscwbsn_18b,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Divider(
  //             height: h_01,
  //           ),
  //           listOfNewdefects(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget listOfNewdefects() {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: listNewDamage.length,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemBuilder: (context, index) {
  //         return CommonPreTripListTile(
  //           strTitle: listNewDamage[index].strTitle,
  //           strSubTitle: listNewDamage[index].strSubTitle,
  //           isavail: listNewDamage[index].isCheck,
  //           check: listNewDamage[index].check,
  //           strStatus: listNewDamage[index].strStatus,
  //           strImage: listNewDamage[index].strImage,
  //         );
  //       });
  // }

// submit button
  Widget submit() {
    return CommonButton(
      color: appColor,
      strBtnText: strSubmit,
      dWidth: h_100,
    );
  }
}
