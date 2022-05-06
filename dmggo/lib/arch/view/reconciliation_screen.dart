import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_dropdown.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/models/pretrip_inspec_popup_model.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:flutter/material.dart';

class Reconciliation extends StatelessWidget {
  final String strTitle;
  Reconciliation({Key? key, required this.strTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: h_0,
        centerTitle: false,
        title: Text(
          strTitle,
          style: grfwbsn_18wh,
        ),
      ),
      backgroundColor: cgrey_200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(strTitle: strRoutePay, isWeekAvail: true),
              body(listReconRoutePay, context),
              header(strTitle: strEquipment, isWeekAvail: true),
              body(listReconEqup, context),
              header(strTitle: strSYtoD),
              body(listReconRoutePay, context),
            ],
          ),
        ),
      ),
    );
  }

//Common header for expenses
  Widget header({required String strTitle, bool? isWeekAvail}) {
    return Padding(
      padding: EdgeInsets.all(h_10),
      child: Row(
        children: [
          Expanded(
            flex: i_2,
            child: Text(
              strTitle,
              style: grfwbsn_16b,
            ),
          ),
          isWeekAvail != null && isWeekAvail
              ? Expanded(
                  flex: i_2,
                  child: CommonDropdown(
                    strSelectedValue: listWeek[i_0],
                    listdata: listWeek,
                    textStyle: grfwnsn_14b,
                  ))
              : sbh_5w_5,
          sbh_5w_5,
          Expanded(
              flex: i_2,
              child: CommonDropdown(
                strSelectedValue: listYear[i_0],
                listdata: listYear,
                textStyle: grfwnsn_14b,
              ))
        ],
      ),
    );
  }

//Common body for expenses
  Widget body(List<PTIP> list, BuildContext con) {
    return Container(
      color: cwhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          listExpanses(list),
          Padding(
            padding: EdgeInsets.only(left: h_15, right: h_15),
            child: Column(
              children: [
                dispute(con),
                Divider(
                  height: h_05,
                  color: cgrey,
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(h_5), child: btnViewInvoice())
        ],
      ),
    );
  }

// button for invoice
  Widget btnViewInvoice() {
    return CommonButton(
      color: appColor,
      dWidth: screenWidth! / i_2,
      textStyle: grfwbsn_14wh,
      strBtnText: strVLI,
    );
  }

// List of expenses view
  Widget listExpanses(List<PTIP> list) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: h_15, right: h_15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(h_15),
                      child: Text(
                        list[index].strImage,
                        style: grfwbsn_14b,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(h_15),
                      child: Text(
                        list[index].strDescription,
                        style: grfwnsn_14b,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: h_05,
                  color: cgrey,
                )
              ],
            ),
          );
        });
  }

  Widget dispute(BuildContext conDispute) {
    return Container(
      color: camber_50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: i_2,
            child: GestureDetector(
              onTap: () {
                showDisputeAlert(conDispute);
              },
              child: Padding(
                padding: EdgeInsets.all(h_15),
                child: Text(
                  strReportedDispute,
                  style: grfwbsndul_14blu,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: h_40,
              child: DropdownButtonFormField(
                onTap: () {},
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ctransparent)),
                  contentPadding: EdgeInsets.symmetric(vertical: h_1, horizontal: h_5),
                ),
                value: listDispute[i_0],
                style: grfwnsn_10b,
                isExpanded: true,
                items: listDispute
                    .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value == listDispute[2]) {
                    showAlert(conDispute);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  showAlert(BuildContext conDialog) {
    showDialog(
        context: conDialog,
        builder: (_) {
          return AlertDialog(
            shape: rrbr_10,
            title: Text(
              strWriteAboutDispute,
              style: grfwbsn_16b,
            ),
            content: Comtextfield(
              strHintText: strTellUsMoreAboutTheDispute,
              strLabelText: strTellUsMoreAboutTheDispute,
              iMaxLines: i_3,
            ),
            actions: [
              CommonButton(
                color: cgrey_500,
                dWidth: h_100,
                strBtnText: strCancel.toLowerCase(),
                onPressed: () {
                  Navigator.pop(conDialog);
                },
              ),
              CommonButton(
                color: appColor,
                dWidth: h_100,
                strBtnText: strSubmit.toLowerCase(),
                onPressed: () {
                  Navigator.pop(conDialog);
                },
              )
            ],
          );
        });
  }

  showDisputeAlert(BuildContext conDialog) {
    showDialog(
        context: conDialog,
        builder: (_) {
          return AlertDialog(
            shape: rrbr_10,
            title: Text(
              strDiscussionAboutTheDispute,
              style: grfwbsn_16b,
            ),
            content: Comtextfield(
              controller: TextEditingController(text: dummyStrReportedDispute),
              strHintText: strAllAboutTheDispute,
              strLabelText: strAllAboutTheDispute,
              iMaxLines: i_3,
            ),
            actions: [
              CommonButton(
                color: cwhite,
                dWidth: h_100,
                strBtnText: strCancel.toLowerCase(),
                textStyle: grfwbsn_14b,
                onPressed: () {
                  Navigator.pop(conDialog);
                },
              ),
            ],
          );
        });
  }
}
