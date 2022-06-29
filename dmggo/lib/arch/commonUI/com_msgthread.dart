import 'dart:io';
import 'package:dmggo/arch/repo/apis.dart';
import 'package:http/http.dart' as http;

import 'package:dmggo/arch/commonUI/chatUI/left_chat_bubble.dart';
import 'package:dmggo/arch/commonUI/chatUI/right_chat_bubble.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class CommonMessageThread extends StatefulWidget {
  final bool isMsgReceived;
  final bool isGroup;
  final bool isSameId;
  final bool isSameDay;
  final QBMessage? message;
  final int intNoOfMembers;
  CommonMessageThread({
    Key? key,
    required this.message,
    required this.isGroup,
    required this.isSameId,
    required this.isSameDay,
    required this.isMsgReceived,
    required this.intNoOfMembers,
  }) : super(key: key);

  @override
  State<CommonMessageThread> createState() => _CommonMessageThreadState();
}

class _CommonMessageThreadState extends State<CommonMessageThread> {
  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(widget.message!.dateSent!);
    var d12 = DateFormat('hh:mm a').format(dt); // 12/31/2000, 10:00 PM
    var d1 = DateFormat('dd/MM/yyyy').format(dt); // 12/31/2000, 10:00 PM

    return Column(
      crossAxisAlignment: widget.isMsgReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        if (!widget.isSameDay)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                d1,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ),
        if (!widget.isSameId && widget.isGroup && widget.message!.properties!['sendername'] != null)
          Padding(
            padding: EdgeInsets.only(left: 5, top: 5, right: 5),
            child: Text(
              widget.message!.properties!['sendername']!,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isMsgReceived) LeftChatBubble(message: widget.message!, widgetOf: decision(ctDecision: context), strMsgTime: d12),
            if (!widget.isMsgReceived)
              RightChatBubble(
                message: widget.message!,
                widgetOf: decision(ctDecision: context),
                strMsgTime: d12,
                isGroup: widget.isGroup,
                intGroupCount: widget.intNoOfMembers,
              )
            // Container(
            //   constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / hp_12),
            //   child: Stack(
            //     children: [
            //       Card(
            //         color: cgrey_200,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.all(h_5),
            //               child: Text(
            //                 strMessage,
            //                 style: tscwnsn_16b,
            //                 textAlign: TextAlign.justify,
            //               ),
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(right: !isMsgReceived ? h_20 : h_2, left: h_5),
            //               child: Text(
            //                 d12,
            //                 style: tscwnsn_12gy,
            //                 textAlign: TextAlign.right,
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //       if (!isMsgReceived)
            //         Positioned(
            //             right: h_5,
            //             bottom: h_5,
            //             child: Icon(
            //               strStatus == status.await.toString()
            //                   ? Icons.access_time_rounded
            //                   : strStatus == status.delivered.toString()
            //                       ? Icons.check
            //                       : Icons.check,
            //               size: h_15,
            //               color: strStatus == status.read.toString() ? cblue_300 : cgrey_400,
            //             ))
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Widget decision({required BuildContext ctDecision}) {
    return widget.message!.attachments != null && widget.message!.attachments!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [attchmentsHandle(ctattach: ctDecision), if ( widget.message!.body != null) textHandle(widget.message!.body!)],
          )
        : textHandle(widget.message!.body!);
  }

  Widget textHandle(String strMessage) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 15),
      child: Container(
        constraints: BoxConstraints(minWidth: 60),
        child: Text(
          strMessage,
          softWrap: true,
          style: tscwnsn_14b,
        ),
      ),
    );
  }

  Widget attchmentsHandle({required BuildContext ctattach}) {
    return
        // message!.attachments!.length > 2
        //     ? GridView.builder(
        //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 2 / 2, crossAxisSpacing: 15, mainAxisSpacing: 5),
        //         itemCount: message!.attachments!.length < 4 ? message!.attachments!.length : 4,
        //         shrinkWrap: true,
        //         physics: NeverScrollableScrollPhysics(),
        //         itemBuilder: (BuildContext ctx, index) {
        //           return Stack(
        //             children: [
        //               message!.attachments![index]!.type == 'Attachment'
        //                   ? file(bottom: h_15, ctImage: ctattach, strFile: message!.attachments![index]!.contentType!.split('/')[1])
        //                   : imageLoad(urlImage: message!.attachments![index]!.url!, ctImage: ctattach, bottom: h_15),
        //               if (message!.attachments!.length > 4 && index == 3)
        //                 Container(
        //                   color: cgrey_200.withOpacity(0.4),
        //                   width: MediaQuery.of(ctattach).size.width * 0.60,
        //                   height: MediaQuery.of(ctattach).size.height * 0.25,
        //                   child: Center(
        //                     child: Text(
        //                       '+ ${message!.attachments!.length - 4}',
        //                       style: tscw400sn_25b,
        //                     ),
        //                   ),
        //                 )
        //             ],
        //           );
        //         })
        //     :
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.message!.attachments!.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  widget.message!.attachments![index]!.type == 'Attachment'
                      ? file(
                          bottom: h_15,
                          ctImage: ctattach,
                          strFile: widget.message!.attachments![index]!.name == null
                              ? 'File.' + widget.message!.attachments![index]!.contentType!.split('/')[1]
                              : widget.message!.attachments![index]!.name!)
                      : imageLoad(urlImage: widget.message!.attachments![index]!.url!, ctImage: ctattach, bottom: h_15),
                  Positioned(
                      right: 15,
                      top: 1,
                      child: IconButton(
                        icon: Icon(Icons.download_rounded),
                        color: cblue,
                        onPressed: () {
                          _downloadFile(widget.message!.attachments![index]!.url!, widget.message!.attachments![index]!.name!, widget.message!.attachments![index]!.id!);
                        },
                      ))
                ],
              );
            });
  }

  Widget imageLoad({String? urlImage, required BuildContext ctImage, double? bottom}) {
    return Padding(
        padding: EdgeInsets.only(bottom: bottom!),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          child: Image.network(
            urlImage!,

            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: MediaQuery.of(ctImage).size.width * 0.75,
                height: MediaQuery.of(ctImage).size.height * 0.25,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                  ),
                ),
              );
            },
            // CircularPercentIndicator(
            //   radius: 30,
            //   progressColor: cgreen,
            //   backgroundColor: cgrey_100,
            //   percent: loadingProgress!.cumulativeBytesLoaded / 100,
            // ),
            width: MediaQuery.of(ctImage).size.width * 0.60,
            height: MediaQuery.of(ctImage).size.height * 0.25,
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget file({
    double? bottom,
    String? strFile,
    required BuildContext ctImage,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom!),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          child: Container(
            color: appColor.withOpacity(0.3),
            width: MediaQuery.of(ctImage).size.width * 0.60,
            height: MediaQuery.of(ctImage).size.width * 0.20,
            child: Row(
              children: [
                Image.asset(imgFile),
                SizedBox(
                  width: MediaQuery.of(ctImage).size.width * 0.40,
                  child: Text(
                    strFile!,
                    style: tscwnsn_14b,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                  ),
                )
              ],
            ),
          )),
    );
  }

  HttpClient httpClient = HttpClient();
  _downloadFile(String url, String filename, String id) async {
    print(url);
    print(filename);
    Directory directory = await getApplicationDocumentsDirectory();
    // Platform.isAndroid
    //     ? await getExternalStorageDirectory() //FOR ANDROID
    //     : await getApplicationSupportDirectory();
    Directory dir = Directory(directory.path + '/DMGgo');
    String? folderName;
    if (await dir.exists()) {
      folderName = dir.path;
    } else {
      final Directory _appDocDirNewFolder = await dir.create(recursive: true);
      folderName = _appDocDirNewFolder.path;
    }
    File file = File('$folderName/$filename');
    if (await file.exists()) {
      SnackBar s2 = SnackBar(
        content: Text('Downloaded'),
        action: SnackBarAction(
          label: 'open',
          onPressed: () {
            OpenFile.open(file.path);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(s2);
    } else {
      SnackBar s = SnackBar(content: Text('Downloading file'));
      ScaffoldMessenger.of(context).showSnackBar(s);
      try {
        var request = await Apis().getApi(strLUrl: url);

        print(request);
        // HttpClientResponse response = await request.close();
        if (request.statusCode == 200) {
          // var bytes = await consolidateHttpClientResponseBytes(request.bodyBytes);

          await file.writeAsBytes(request.bodyBytes);

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          SnackBar s2 = SnackBar(
            content: Text('Downloaded'),
            action: SnackBarAction(
              label: 'open',
              onPressed: () {
                OpenFile.open(file.path);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(s2);
        }
      } catch (e) {
        print(e);
      }
    }
    // return file;
    // }).asStream();
    // var r = request.asBroadcastStream();
    // r.listen((event) {
    //   print(event);
    // });

    // var response = await request.close();

    // http.Response r = await http.get(Uri.parse(url), headers: {'Accept': 'text/plain'});
    // print(r);
  }
}
