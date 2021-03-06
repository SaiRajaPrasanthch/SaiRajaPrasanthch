import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_textfield.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view/chat_screen.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';

class ChatGroupCreation extends StatefulWidget {
  const ChatGroupCreation({Key? key}) : super(key: key);

  @override
  State<ChatGroupCreation> createState() => _ChatGroupCreationState();
}

class _ChatGroupCreationState extends State<ChatGroupCreation> {
  TextEditingController txtName = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: h_0,
        iconTheme: IconThemeData(
          color: cblack, //change your color here
        ),
        backgroundColor: cgrey_50,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              strCreateGroup,
              style: tscwbsn_18b,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(imgGroupChat ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: txtGroupName(context: context),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(h_5),
                  child: CommonButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (txtName.text.trim().isNotEmpty) {
                        QBDialog createdDialog = await ChatApi().createDialog(listusers: listUsersSelected, strDialogName: txtName.text.trim(), intDialogType: QBChatDialogTypes.GROUP_CHAT);

                        setState(() {
                          isLoading = false;
                        });
                        exitScreen(context);
                        exitScreen(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      bIsGroup: true,
                                      strName: createdDialog.name!,
                                      strDialogId: createdDialog.id!,
                                      intNoOfMembers: listUsersSelected.length,
                                    )));
                        listUsersSelected = [];
                        return;
                      }
                    },
                    color: txtName.text.trim().isEmpty ? cgrey_300 : appColor,
                    dWidth: screenWidth!,
                    strBtnText: strNext,
                  ),
                )
              ],
            ),
            if (isLoading)
              Container(
                height: screenHeight,
                width: screenWidth,
                color: cgrey_100.withOpacity(0.5),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget txtGroupName({required BuildContext context}) {
    return Comtextfield(
      onChanged: (value) {
        setState(() {
          txtName.text = value;
          txtName.selection = TextSelection.fromPosition(TextPosition(offset: txtName.text.length));
        });
      },
      textStyle: tscwnsn_16b,
      controller: txtName,
      strHintText: strEnterGroupName,
      strLabelText: strEnterGroupName,
      border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: brCir_5),
    );
  }
}
