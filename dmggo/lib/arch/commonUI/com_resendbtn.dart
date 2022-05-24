import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';

typedef Callback = void Function(bool val);

class ResendOTP extends StatefulWidget {
  final Callback? callback;
  final String? strMobile;

  ResendOTP({Key? key, this.callback, this.strMobile}) : super(key: key);
  @override
  _ResendOTPState createState() => _ResendOTPState();
}

class _ResendOTPState extends State<ResendOTP> with SingleTickerProviderStateMixin {
  int timer = 30; // getUserByPhonenumber;

  bool loader = false;
  late Timer tTimer;
  // @override
  // void initState() {
  //   timers();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   tTimer.cancel();
  //   super.dispose();
  // }

  resendOTP() async {
    // print(_radioValue1);
    // setState(() {
    //   loader = true;
    // });
    // var res = await GetCalls().getOTP(widget.strMobile);
    // print(res);
    // var resBody = json.decode(res.body);

    // setState(() {
    //   timer = 30;
    //   timers();
    //   loader = false;
    //   widget.callback(false);
    // });
  }

  timers() {
    // tTimer = new Timer(Duration(seconds: 1), () {
    //   setState(() {
    //     timer--;
    //     strResend = timer == 0
    //         ? "Resend" //allTranslations.text('textResend')
    //         : 'Resend $timer';
    //   });
    //   if (timer != 0) timers();
    // });
  }
  @override
  Widget build(BuildContext context) {
    return !loader
        ? OutlinedButton(
            // color: timer == 0 ? Colors.blue : Colors.grey,
            // borderSide: BorderSide(
            //     color: timer == 0 ? Colors.blue : Colors.grey),
            // textColor: timer == 0 ? Colors.blue : Colors.grey,
            onPressed: timer == 0
                ? () {
                    resendOTP();
                  }
                : null,
            child: Text(
              strResend,
              style: tscwnsn_14b,
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
