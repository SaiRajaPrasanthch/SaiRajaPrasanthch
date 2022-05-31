import 'package:dmggo/arch/commonUI/chatUI/chat_user_tile_checkbtn.dart';
import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/chatlist_log.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class ChatUsersGroupSelection extends StatefulWidget {
  const ChatUsersGroupSelection({Key? key}) : super(key: key);

  @override
  State<ChatUsersGroupSelection> createState() => _ChatUsersGroupSelectionState();
}

class _ChatUsersGroupSelectionState extends State<ChatUsersGroupSelection> {
  @override
  void initState() {
    super.initState();
    listUsersSelected.add(qbUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        listUsersSelected.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: h_0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select the Users',
                style: tscwbsn_18wh,
              ),
            ],
          ),
          // actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          // ],
        ),
        body: SafeArea(
          child: userList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(child: listUsers(context: context)),
                    Padding(
                      padding: EdgeInsets.all(h_5),
                      child: CommonButton(
                        onPressed: () {
                          setState(() {});
                          if (listUsersSelected.isEmpty) {
                            return;
                          }

                          if (listUsersSelected.length == i_2) {
                            // Fluttertoast.showToast(
                            //     msg: "please select minimum two users. To create a group",
                            //     toastLength: Toast.LENGTH_LONG,
                            //     gravity: ToastGravity.CENTER,
                            //     timeInSecForIosWeb: 1,
                            //     backgroundColor: Colors.red,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0);
                            return;
                          }
                          openGroupCreation(context);
                        },
                        color: listUsersSelected.isNotEmpty ? appColor : cgrey_300,
                        dWidth: screenWidth!,
                        strBtnText: strNext,
                      ),
                    )
                  ],
                )
              : Center(
                  child: Text(
                    'No User are Available to chat',
                    style: tscwbsn_14gy500,
                  ),
                ),
        ),
      ),
    );
  }

  Widget listUsers({required BuildContext context}) {
    return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          bool isChecked = listUsersSelected.contains(userList[index]!.id!);
          return GestureDetector(
            onTap: () async {
              await ChatListViewModel().selectUsersForGroupCreation(index: index);
              setState(() {});
            },
            child: ChatUserTileCheckBtn(
              strUserName: userList[index]!.fullName!,
              isChecked: isChecked,
            ),
          );
        });
  }
}
