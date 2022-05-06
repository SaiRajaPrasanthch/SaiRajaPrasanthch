import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:flutter/material.dart';

class DrvierClockPunch extends StatelessWidget {
  final String strTitle;

  DrvierClockPunch({Key? key, required this.strTitle}) : super(key: key);

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColoredBox(
                      color: cgrey_300,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      )),
                  Row(
                    children: [
                      Text(
                        '28-03-2022',
                        style: grfwbsn_16b,
                      ),
                      sbh_5w_5,
                      Text(
                        '(TH - 4hrs)',
                        style: grfwbsn_14gy500,
                      ),
                    ],
                  ),
                  ColoredBox(color: cgrey_300, child: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_rounded))),
                ],
              ),
              Divider(
                height: h_05,
                color: cblack,
              ),
              Padding(
                padding: EdgeInsets.all(h_5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Card(
                          shape: StadiumBorder(side: BorderSide(width: h_3, color: Colors.green.shade400)),
                          child: Padding(
                            padding: EdgeInsets.all(h_15),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/images/punch.png',
                                    height: 100,
                                    fit: BoxFit.contain,
                                    color: Colors.green.shade400,
                                  ),
                                ),
                                Positioned(
                                  bottom: -4,
                                  child: Text(
                                    'IN',
                                    textAlign: TextAlign.center,
                                    style: grfwbsn_18b,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          elevation: 0,
                        ),
                        Positioned(
                          right: 5,
                          bottom: 10,
                          child: Card(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Icon(
                                Icons.check,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            elevation: 0,
                            color: Colors.green.shade400,
                            shape: StadiumBorder(),
                          ),
                        )
                      ],
                    ),
                    sbh_5w_10,
                    Text(
                      '09:00',
                      style: grfwbsn_18b,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(h_5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Card(
                          shape: StadiumBorder(side: BorderSide(width: h_3, color: Colors.yellow.shade400)),
                          child: Padding(
                            padding: EdgeInsets.all(h_20),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/images/lunch.png',
                                    height: 90,
                                    fit: BoxFit.contain,
                                    color: Colors.yellow.shade400,
                                  ),
                                ),
                                Positioned(
                                  bottom: -4,
                                  child: Text(
                                    'IN',
                                    textAlign: TextAlign.center,
                                    style: grfwbsn_18b,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          elevation: 0,
                        ),
                        Positioned(
                          right: 5,
                          bottom: 10,
                          child: Card(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Icon(
                                Icons.warning_amber,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            elevation: 0,
                            color: Colors.yellow.shade400,
                            shape: StadiumBorder(),
                          ),
                        )
                      ],
                    ),
                    sbh_5w_10,
                    Text(
                      '00:00',
                      style: grfwbsn_18b,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(h_5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Card(
                          shape: StadiumBorder(side: BorderSide(width: h_3, color: Colors.grey.shade300)),
                          child: Padding(
                            padding: EdgeInsets.all(h_20),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/images/lunch.png',
                                    height: 90,
                                    fit: BoxFit.contain,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                Positioned(
                                  bottom: -4,
                                  child: Text(
                                    'OUT',
                                    textAlign: TextAlign.center,
                                    style: grfwbsn_18b,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          elevation: 0,
                        ),
                        Positioned(
                          right: 5,
                          bottom: 10,
                          child: Card(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                            ),
                            elevation: 0,
                            color: Colors.grey.shade300,
                            shape: StadiumBorder(),
                          ),
                        )
                      ],
                    ),
                    sbh_5w_10,
                    Text(
                      '00:00',
                      style: grfwbsn_18b,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(h_5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Card(
                          shape: StadiumBorder(side: BorderSide(width: h_3, color: Colors.grey.shade300)),
                          child: Padding(
                            padding: EdgeInsets.all(h_15),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/images/punch.png',
                                    height: 100,
                                    fit: BoxFit.contain,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                Positioned(
                                  bottom: -4,
                                  child: Text(
                                    'OUT',
                                    textAlign: TextAlign.center,
                                    style: grfwbsn_18b,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          elevation: 0,
                        ),
                        Positioned(
                          right: 5,
                          bottom: 10,
                          child: Card(
                            elevation: 0,
                            child: SizedBox(
                              height: 25,
                              width: 25,
                            ),
                            color: Colors.grey.shade300,
                            shape: StadiumBorder(),
                          ),
                        )
                      ],
                    ),
                    sbh_5w_10,
                    Text(
                      '00:00',
                      style: grfwbsn_18b,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
