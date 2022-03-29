import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/dummies.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/view/login_screen.dart';
import 'package:dmggo/arch/view_model/profile_log.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileLogic profileLogic = Provider.of<ProfileLogic>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          strLProfile,
          style: grfwbsn_18wh,
        ),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(h_10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (strEmail != dummyStrDriverEmail &&
                strEmail != dummyStrDrFirstimEmail)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      profileLogic.toggleNotification(
                          isNotifiable: !profileLogic.isNotifiable);
                    },
                    child: Column(
                      children: [
                        Card(
                          shape: StadiumBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(h_8),
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: h_100,
                              color: profileLogic.isNotifiable
                                  ? cgrey_500
                                  : cblack,
                            ),
                          ),
                        ),
                        Text(
                          profileLogic.strSwitch,
                          style: profileLogic.isNotifiable
                              ? grfwnsn_16gy500
                              : grfwnsn_16b,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      profileLogic.toggleNotification(
                          isNotifiable: !profileLogic.isNotifiable);
                    },
                    child: Column(
                      children: [
                        Card(
                          shape: StadiumBorder(),
                          child: Padding(
                            padding:  EdgeInsets.all(h_8),
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: h_100,
                              color: profileLogic.isNotifiable
                                  ? cblack
                                  : cgrey_500,
                            ),
                          ),
                        ),
                        Text(
                          strDriver,
                          style: profileLogic.isNotifiable
                              ? grfwnsn_16b
                              : grfwnsn_16gy500,
                        )
                      ],
                    ),
                  )
                ],
              ),
           
            CommonButton(
              onPressed: () {
                currentTab.removeAt(i_0);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
              color: appColor,
              dWidth: screenWidth!,
              strBtnText: strLogout,
              textStyle: grfwbsn_18wh,
            )
          ],
        ),
      )),
    );
  }
}
