import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/view_model/profile_log.dart';
// import 'package:dmggo/arch/view_model/profile_log.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: h_0,
          centerTitle: false,
          title: Text(
            strLProfile,
            style: tscwbsn_18wh,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(left: h_10, right: h_10, top: h_5, bottom: h_5),
              child: Card(
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: h_40,
                        backgroundColor: cwhite,
                        child: Image.asset(
                          'assets/images/profile.png',
                        )),
                    Padding(
                      padding: EdgeInsets.all(h_5),
                      child: Text(
                        'Frank McGuire',
                        style: tscwbsn_16b,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(h_5),
                      child: Text(
                        'Frank.mc@dmggo-owner.com',
                        style: tscwnsn_16b,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(h_10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Owner',
                            style: tscwnsn_16do,
                          ),
                          ColoredBox(
                            color: appColor,
                            child: sbh_15w_2,
                          ),
                          Text(
                            '1234567890',
                            style: tscwnsn_16do,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: h_10, right: h_10, top: h_5, bottom: h_5),
              child: Card(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: h_15, top: h_10),
                          child: Text(
                            'Full Name',
                            style: tscwnsn_16gy500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_20, top: h_10, bottom: h_10),
                          child: Text(
                            'Frank McGuire',
                            style: tscwbsn_16b,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(h_10),
                          child: Divider(
                            color: cgrey_500,
                            height: h_05,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_15, top: h_10),
                          child: Text(
                            'Date Of Birth',
                            style: tscwnsn_16gy500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_20, top: h_10, bottom: h_10),
                          child: Text(
                            '11/04/1981',
                            style: tscwbsn_16b,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(h_10),
                          child: Divider(
                            color: cgrey_500,
                            height: h_05,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_15, top: h_10),
                          child: Text(
                            'Email',
                            style: tscwnsn_16gy500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_20, top: h_10, bottom: h_10),
                          child: Text(
                            'Frank.mc@dmggo-owner.com',
                            style: tscwbsn_16b,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(h_10),
                          child: Divider(
                            color: cgrey_500,
                            height: h_05,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_15, top: h_10),
                          child: Text(
                            'Mobile #',
                            style: tscwnsn_16gy500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_20, top: h_10, bottom: h_10),
                          child: Text(
                            '123-456-7890',
                            style: tscwbsn_16b,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(h_10),
                          child: Divider(
                            color: cgrey_500,
                            height: h_05,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_15, top: h_10),
                          child: Text(
                            'Driving License #',
                            style: tscwnsn_16gy500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: h_20, top: h_10, bottom: h_30),
                          child: Text(
                            's230-123-456-7890',
                            style: tscwbsn_16b,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: h_30,
                        right: h_10,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue.shade600,
                          child: Icon(
                            Icons.edit,
                            color: cwhite,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            btnLogOut(context: context)
          ]),
        ));
  }

  Widget btnLogOut({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(h_12),
      child: CommonButton(
        color: appColor,
        strBtnText: strLogout,
        dWidth: screenWidth!,
        onPressed: () {
          Provider.of<ProfileLogic>(context, listen: false).logout(con: context);
         
        },
      ),
    );
  }
}

//  Center(
//           child: Padding(
//         padding: EdgeInsets.all(h_10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             if (strEmail != dummyStrDriverEmail &&
//                 strEmail != dummyStrDrFirstimEmail)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       profileLogic.toggleNotification(
//                           isNotifiable: !profileLogic.isNotifiable);
//                     },
//                     child: Column(
//                       children: [
//                         Card(
//                           shape: StadiumBorder(),
//                           child: Padding(
//                             padding: EdgeInsets.all(h_8),
//                             child: Icon(
//                               Icons.person_outline_rounded,
//                               size: h_100,
//                               color: profileLogic.isNotifiable
//                                   ? cgrey_500
//                                   : cblack,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           profileLogic.strSwitch,
//                           style: profileLogic.isNotifiable
//                               ? tscwnsn_16gy500
//                               : tscwnsn_16b,
//                         )
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       profileLogic.toggleNotification(
//                           isNotifiable: !profileLogic.isNotifiable);
//                     },
//                     child: Column(
//                       children: [
//                         Card(
//                           shape: StadiumBorder(),
//                           child: Padding(
//                             padding:  EdgeInsets.all(h_8),
//                             child: Icon(
//                               Icons.person_outline_rounded,
//                               size: h_100,
//                               color: profileLogic.isNotifiable
//                                   ? cblack
//                                   : cgrey_500,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           strDriver,
//                           style: profileLogic.isNotifiable
//                               ? tscwnsn_16b
//                               : tscwnsn_16gy500,
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),

//             CommonButton(
//               onPressed: () {
//                 currentTab.removeAt(i_0);
//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
//                     (Route<dynamic> route) => false);
//               },
//               color: appColor,
//               dWidth: screenWidth!,
//               strBtnText: strLogout,
//               textStyle: tscwbsn_18wh,
//             )
//           ],
//         ),
//       )),
