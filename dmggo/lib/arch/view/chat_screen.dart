import 'dart:async';
import 'dart:io';
import 'package:dmggo/arch/commonUI/com_msgthread.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/models/file_upload_model.dart';
import 'package:dmggo/arch/repo/chat_api.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_assets.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/chatmsglist_log.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickblox_sdk/file/constants.dart';
import 'package:quickblox_sdk/mappers/qb_message_mapper.dart';
import 'package:quickblox_sdk/models/qb_attachment.dart';
import 'package:quickblox_sdk/models/qb_file.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatScreen extends StatefulWidget {
  final String strName;
  final String? strProfileImg;
  final bool bIsGroup;
  final String strDialogId;
  final int intNoOfMembers;
  ChatScreen({Key? key, required this.strName, this.strProfileImg, required this.bIsGroup, required this.strDialogId, required this.intNoOfMembers}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatMsgListProvider _chatMsgListViewModel = ChatMsgListProvider();
  Map<String, String> properties = {};
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? subReceiveMsg;
  StreamSubscription? subDeliveredMsg;
  StreamSubscription? subReadMsg;
  int _limit = i_40;
  bool isTop = false;
  bool isLoading = false;
  List<String> listFile = [];
  List<int> listProgress = [];
  @override
  void initState() {
    super.initState();
    getUpdatedMessages();
    getDeliveredMessages();
    getReadMessages();
    getData(_limit);
  }

  Future<void> getData(int limit) async {
    setState(() {
      isLoading = true;
    });
    await _chatMsgListViewModel.chatMessages(strRoomId: widget.strDialogId, limit: limit);
    setState(() {
      isLoading = false;
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (_scrollController.hasClients && !isTop) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  getUpdatedMessages() async {
    subReceiveMsg = await QB.chat.subscribeChatEvent(qbEventReceiveNewMessage, (data) {
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
      Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
      QBMessage? msg = QBMessageMapper.mapToQBMessage(payload);
      Iterable<QBMessage?> msgExist = _chatMsgListViewModel.messages.where((element) => element!.id == msg!.id && widget.strDialogId == msg.dialogId);
      if (!msgExist.isNotEmpty) {
        _chatMsgListViewModel.messages.add(msg);
        ChatApi().markDelivered(msg!);

        Future.delayed(Duration(seconds: 1), () {
          ChatApi().markRead(msg);
        });
        setState(() {});
      }

      setState(() {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            // if (msgExist.isNotEmpty) {

            // }
          }
        });
      });
    });
  }

  getDeliveredMessages() async {
    subDeliveredMsg = await QB.chat.subscribeChatEvent(qbDeliveredMessage, (data) {});
    subDeliveredMsg!.onData((data) {
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
      Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
      String messageId = payload["messageId"];
      int userId = payload["userId"];
      String statusType = map["type"];
      addRecipt(intUserId: userId, strMessageId: messageId, strStatusType: statusType);
    });
  }

  getReadMessages() async {
    subReadMsg = await QB.chat.subscribeChatEvent(qbReadMessage, (data) {});
    subReadMsg!.onData((data) {
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
      Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
      String messageId = payload["messageId"];
      int userId = payload["userId"];
      String statusType = map["type"];
      Future.delayed(Duration(seconds: 1), () {
        addRecipt(intUserId: userId, strMessageId: messageId, strStatusType: statusType);
      });
    });
  }

  addRecipt({
    int? intUserId,
    String? strStatusType,
    String? strMessageId,
  }) {
    QBMessage m = QBMessage();
    Iterable<QBMessage?> msgExist = _chatMsgListViewModel.messages.where((element) => element!.id == strMessageId);
    if (msgExist.isNotEmpty) {
      m = msgExist.first!;
    }

    if (strStatusType!.contains('MESSAGE_DELIVERED')) {
      // _chatMsgListViewModel.messages.where((element) {
      //   if (element!.id == strMessageId) {
      //     if (!element.deliveredIds!.contains(intUserId)) {
      //       element.deliveredIds!.add(intUserId!);
      //     }

      //     return true;
      //   }

      //   return false;
      // });
      if (!m.deliveredIds!.contains(intUserId)) {
        m.deliveredIds!.add(intUserId!);
        int index = _chatMsgListViewModel.messages.indexWhere((element) => element!.id == strMessageId);
        _chatMsgListViewModel.messages.removeWhere((element) => element!.id == strMessageId);
        _chatMsgListViewModel.messages.insert(index, m);
      }
    }
    if (strStatusType.contains('MESSAGE_READ')) {
      // _chatMsgListViewModel.messages.where((element) {
      //   if (element!.id == strMessageId) {
      //     if (!element.readIds!.contains(intUserId)) {
      //       element.readIds!.add(intUserId!);
      //     }

      //     return true;
      //   }
      //   return false;
      // });
      if (!m.readIds!.contains(intUserId)) {
        m.readIds!.add(intUserId!);
        int index = _chatMsgListViewModel.messages.indexWhere((element) => element!.id == strMessageId);
        _chatMsgListViewModel.messages.removeWhere((element) => element!.id == strMessageId);
        _chatMsgListViewModel.messages.insert(index, m);
      }
    }

    setState(() {
      // WidgetsBinding.instance?.addPostFrameCallback((_) {
      //   if (_scrollController.hasClients) {
      //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      //   }
      // });
    });
  }

  @override
  void dispose() {
    if (subReceiveMsg != null) {
      subReceiveMsg!.cancel();
      subReceiveMsg = null;
    }
    if (subDeliveredMsg != null) {
      subDeliveredMsg!.cancel();
      subDeliveredMsg = null;
    }
    if (subReadMsg != null) {
      subReadMsg!.cancel();
      subReadMsg = null;
    }
    // viewKey.currentState?.getData();
    // viewKey.currentState?.reDraw();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: false,
          elevation: h_0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Icon(widget.bIsGroup ? Icons.groups_rounded : Icons.person),
              ),
              sbh_5w_5,
              Expanded(
                flex: 4,
                child: Text(
                  widget.strName,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tscwnsn_14wh,
                ),
              ),
            ],
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)), if (!widget.bIsGroup) contactPopupMenu(), if (widget.bIsGroup) groupPopupMenu()],
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (isLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: h_20,
                        width: h_20,
                        child: CircularProgressIndicator(
                          color: cblue_200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Loading old messages',
                          style: tscwnsn_14gy500,
                        ),
                      )
                    ],
                  ),
                ),
              Expanded(child: listMsg(context: context, chatlog: _chatMsgListViewModel.messages)),
              textfield(context: context)
            ],
          ),
        ));
  }

  TextEditingController txtChat = TextEditingController();
// chat textfield with send button add attachment Icon
  Widget textfield({
    required BuildContext context,
  }) {
    return Container(
      alignment: Alignment.bottomCenter,
      color: cgrey_200,
      child: Padding(
        padding: EdgeInsets.all(h_5),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: brCir_20,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          sbh_5w_5,
                          Icon(Icons.insert_emoticon, size: h_30, color: Theme.of(context).hintColor),
                          sbh_5w_5,
                          Expanded(
                            child: TextField(
                              controller: txtChat,
                              maxLines: 4,
                              minLines: 1,
                              decoration: InputDecoration(
                                hintText: strTypeMsg,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          sbh_5w_5,
                          sbh_5w_5,
                          GestureDetector(
                              onTap: () async {
                                showCupertinoModalPopup(context: context, builder: (context) => media());
                                // Map<Permission, PermissionStatus> statuses = await [
                                //   Permission.photos,
                                //   Permission.accessMediaLocation,
                                //   // Permission.manageExternalStorage,
                                //   // Permission.storage,
                                // ].request();
                                // FilePickerResult? result = await FilePicker.platform.pickFiles();

                                // if (result != null) {
                                // File file = File(result.paths);
                                // } else {
                                // User canceled the picker
                                // }
                              },
                              child: Icon(Icons.attach_file, size: h_30, color: Theme.of(context).hintColor)),
                          sbh_5w_5,
                        ],
                      ),
                      if (listFileUpload.isNotEmpty) listFiles(),
                    ],
                  ),
                ),
              ),
            ),
            sbh_5w_5,
            GestureDetector(
              onTap: () async {
                if (listFileUpload.isNotEmpty && listFileUpload.where((element) => element.strFileStatus == 'uploading...').isNotEmpty) {
                  Fluttertoast.showToast(msg: 'upload still in progress');
                  return;
                }
                sendMessage(strMessage: txtChat.text, list: attachmentsList);
                // listFile = [];
                // listProgress = [];
                attachmentsList = [];
                listFileUpload = [];
                txtChat.clear();
              },
              child: CircleAvatar(
                child: Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage({String? strMessage, List<QBAttachment>? list}) async {
         properties["sendername"] = qbUser!.fullName!;

    if (strMessage!.trim().isNotEmpty) {

      await QB.chat.sendMessage(widget.strDialogId, body: strMessage.trim(), saveToHistory: true, markable: true, properties: properties, attachments: list);
    } else if (list!.isNotEmpty) {
      await QB.chat.sendMessage(widget.strDialogId, body: 'Attachments', saveToHistory: true, markable: true, properties: properties, attachments: list);
    }
  }

// popup menu item for group category
  Widget groupPopupMenu() {
    return PopupMenuButton(
        child: Icon(Icons.more_vert_rounded),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  strGroupInfo,
                  style: tscwnsn_16b,
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(
                  strClearChat,
                  style: tscwnsn_16b,
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Text(
                  strMuteNotify,
                  style: tscwnsn_16b,
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Text(
                  strExitGroup,
                  style: tscwnsn_16b,
                ),
                value: 4,
              ),
            ]);
  }

// popup menu item for individual category
  Widget contactPopupMenu() {
    return PopupMenuButton(
        child: Icon(Icons.more_vert_rounded),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  strContInfo,
                  style: tscwnsn_16b,
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(
                  strClearChat,
                  style: tscwnsn_16b,
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Text(
                  strMuteNotify,
                  style: tscwnsn_16b,
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Text(
                  strBlock,
                  style: tscwnsn_16b,
                ),
                value: 4,
              ),
            ]);
  }

// list of message
  Widget listMsg({required BuildContext context, required List<QBMessage?> chatlog}) {
    print(chatlog);
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          isTop = metrics.pixels == 0;
          if (isTop) {
            getData(_limit = _limit + i_40);
          } else {
            isTop = false;
          }
        }
        return true;
      },
      child: ListView.builder(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          itemCount: chatlog.length,
          itemBuilder: (context, index) {
            bool isSameId = false;
            if (index > 0 && chatlog[index]!.senderId == chatlog[index - 1]!.senderId) {
              isSameId = true;
            }
            bool isSameDate = false;

            if (index > 0) {
              DateTime dt = DateTime.fromMillisecondsSinceEpoch(chatlog[index]!.dateSent!);
              DateTime dt1 = DateTime.fromMillisecondsSinceEpoch(chatlog[index - 1]!.dateSent!);
              if (dt1.day == dt.day && dt1.month == dt.month && dt1.year == dt.year) {
                isSameDate = true;
              }
            }
            // 134859157- user

            return CommonMessageThread(
              isGroup: widget.bIsGroup,
              isSameId: isSameId,
              isSameDay: isSameDate,
              isMsgReceived: chatlog[index]!.senderId == qbUser!.id! ? false : true,
              message: chatlog[index],
              intNoOfMembers: widget.intNoOfMembers,
            );
          }),
    );
  }

//Media and storage
  Widget media() {
    return CupertinoActionSheet(
      message: Text(
        'Please pick any file or image upto "25MB"',
        style: tscwnsn_14b,
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            PermissionStatus p = await Permission.camera.request();

            if (p.isDenied || p.isPermanentlyDenied || p.isLimited || p.isLimited) {
              await Permission.photos.request();
            } else {
              final ImagePicker _picker = ImagePicker();

              final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
              print(photo);
              if (photo != null) {
                uploadimage(photo.path);
              } else {
                Fluttertoast.showToast(msg: 'Nothing captured from camera');
              }

              exitScreen(context);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: h_15),
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined),
                sbh_5w_15,
                Text(
                  strCamera,
                  style: tscwnsn_20b,
                ),
              ],
            ),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            PermissionStatus p = await Permission.photos.request();
            final ImagePicker _picker = ImagePicker();
            print(p);
            if (p.isDenied || p.isPermanentlyDenied || p.isLimited || p.isLimited) {
              await Permission.photos.request();
            } else {
              final List<XFile>? images = await _picker.pickMultiImage();
              print(images);
              if (images != null) {
                for (var element in images) {
                  uploadimage(element.path);
                }
              } else {
                Fluttertoast.showToast(msg: 'Nothing Picked');
              }

              exitScreen(context);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: h_15),
            child: Row(
              children: [
                Icon(Icons.photo_outlined),
                sbh_5w_15,
                Text(
                  strPhotoLib,
                  style: tscwnsn_20b,
                ),
              ],
            ),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            PermissionStatus p = await Permission.storage.request();
            print(p);
            if (p.isDenied || p.isPermanentlyDenied || p.isLimited || p.isLimited) {
              await Permission.photos.request();
            } else {
              FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
              print(result);
              if (result != null) {
                for (var element in result.files) {
                  uploadimage(element.path!);
                }
                // File file = File(result.paths);
              } else {
                Fluttertoast.showToast(msg: 'Nothing Picked');
              }

              exitScreen(context);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: h_15),
            child: Row(
              children: [
                Icon(Icons.file_copy_outlined),
                sbh_5w_15,
                Text(
                  strFileDoc,
                  style: tscwnsn_20b,
                ),
              ],
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          exitScreen(context);
        },
        child: Text(
          strCancel,
          style: tscwbsn_18r,
        ),
      ),
    );
  }

  List<QBAttachment> attachmentsList = [];
  QBMessage message = QBMessage();
  bool isUploadInProgress = false;
  List<FileUpload> listFileUpload = [];
  uploadimage(String path) async {
    // if (listFileUpload.length == 5) {
    //   Fluttertoast.showToast(msg: "Max 5 file at time");
    //   return;
    // }
    List fileLen = path.split('/');
    final file = File(path);
    String strStatus;
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 25) {
      strStatus = 'uploading...';
    } else {
      strStatus = 'file size >25 cannot upload';
      listFileUpload.add(FileUpload(strFilePath: path, strFileName: fileLen[fileLen.length - 1], strFileStatus: strStatus, intProgress: i_0));
      return;
    }
    listFileUpload.add(FileUpload(strFilePath: path, strFileName: fileLen[fileLen.length - 1], strFileStatus: strStatus, intProgress: i_0));

    // listFile.add(path);
    // listProgress.insert(listFile.indexOf(path), 0);
    // isUploadInProgress = true;
    setState(() {});
    QB.content.subscribeUploadProgress(path, QBFileUploadProgress.FILE_UPLOAD_PROGRESS, (d) {
      Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(d);
      Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
      setState(() {
        // listProgress[listFile.indexOf(payload['url'])] = payload['progress'];
        int p = listFileUpload.indexWhere((element) => element.strFilePath == payload['url']);
        listFileUpload[p].intProgress = payload['progress'];
      });
    });
    // print(listFile.indexOf(path));
    try {
      QBFile? file = await QB.content.upload(path, public: true);
      String? url = await QB.content.getPublicURL(file!.uid!);
      print(file);
      print(listProgress);
      QBAttachment attachment = QBAttachment();
      attachment.id = file.id.toString();
      attachment.contentType = file.contentType;
      attachment.url = url;
      attachment.name = fileLen[fileLen.length - 1];

      if (file.contentType!.contains('jpg') || file.contentType!.contains('png') || file.contentType!.contains('jpeg')) {
        attachment.type = 'Photo';
      } else {
        attachment.type = 'Attachment';
      }
      int p = listFileUpload.indexWhere((element) => element.strFilePath == path);
      listFileUpload[p].attachment = attachment;
      listFileUpload[p].strFileStatus = 'uploaded';
      attachmentsList.add(attachment);
      // isUploadInProgress = false;
      setState(() {});
    } on PlatformException catch (e) {
      // listProgress.removeAt(listFile.indexOf(path));
      // listFile.remove(path);
      // isUploadInProgress = false;
      int p = listFileUpload.indexWhere((element) => element.strFilePath == path);

      listFileUpload[p].strFileStatus = 'retry';
      setState(() {});
      Fluttertoast.showToast(msg: e.code.toString());
      // Some error occurred, look at the exception message for more details
    } on SocketException catch (e) {
      int p = listFileUpload.indexWhere((element) => element.strFilePath == path);

      listFileUpload[p].strFileStatus = 'retry';
      setState(() {});
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  Widget listFiles() {
    return Column(
      children: listFileUpload.map((e) {
        return Padding(
          padding: EdgeInsets.all(h_3),
          child: Container(
            height: h_40,
            // color: cgreen,
            decoration: bdgrey600brCir_5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(h_5),
                      child: SizedBox(
                        height: h_40,
                        width: h_40,
                        child: e.strFileName!.contains('.jpg') || e.strFileName!.contains('.jpeg') || e.strFileName!.contains('.png')
                            ? Image.file(
                                File(e.strFilePath!),
                                fit: BoxFit.fill,
                              )
                            : Image.asset(imgFile),
                      ),
                    ),
                    if (e.intProgress! > 0)
                      CircularPercentIndicator(
                        radius: 30,
                        progressColor: cgreen,
                        percent: e.intProgress!.toDouble() / 100,
                      ),
                    // GestureDetector(
                    //   onTap: () {
                    //     // listFile.removeAt(index);
                    //     // listProgress.removeAt(index);
                    //     // attachmentsList.removeAt(index);
                    //     listFileUpload.removeAt(index);
                    //     setState(() {});
                    //   },
                    //   child: Card(
                    //     child: Icon(Icons.delete_outline),
                    //   ),
                    // ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth! * 0.5,
                      // constraints: BoxConstraints.loose(MediaQuery.of(context).size * h_05),
                      child: Text(
                        e.strFileName!,
                        maxLines: 1,
                        style: tscwnsn_14b,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      e.strFileStatus!,
                      style: e.strFileStatus == 'uploading...'
                          ? tscwnsn_10gy600
                          : e.strFileStatus == 'uploaded'
                              ? tscwnsn_10green
                              : tscwnsn_10red,
                    )
                  ],
                ),
                if (e.strFileStatus == 'uploaded')
                  IconButton(
                      onPressed: () {
                        int p = listFileUpload.indexWhere((element) => element.strFilePath == e.strFilePath);
                        listFileUpload.removeAt(p);
                        attachmentsList.removeAt(p);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete_outline)),
                if (e.strFileStatus == 'file size >25 cannot upload' || e.strFileStatus == 'retry')
                  IconButton(
                      onPressed: () {
                        int p = listFileUpload.indexWhere((element) => element.strFilePath == e.strFilePath);
                        listFileUpload.removeAt(p);

                        setState(() {});
                      },
                      icon: Icon(Icons.close))
              ],
            ),
          ),
        );
      }).toList(),
    );

    // ListView.builder(
    //     // scrollDirection: Axis.vertical,
    //     // controller: _scrollController,
    //     physics: ClampingScrollPhysics(),
    //     // physics: NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: listFileUpload.length,
    //     itemBuilder: (context, index) {
    //       return Padding(
    //         padding: EdgeInsets.all(h_5),
    //         child: Container(
    //           height: h_40,
    //           // color: cgreen,
    //           decoration: bdgrey600brCir_5,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Stack(
    //                 alignment: AlignmentDirectional.center,
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsets.all(h_5),
    //                     child: SizedBox(
    //                       height: h_40,
    //                       width: h_40,
    //                       child: listFileUpload[index].strFileName!.contains('.jpg') || listFileUpload[index].strFileName!.contains('.jpeg') || listFileUpload[index].strFileName!.contains('.png')
    //                           ? Image.file(
    //                               File(listFileUpload[index].strFilePath!),
    //                               fit: BoxFit.fill,
    //                             )
    //                           : Image.asset(imgFile),
    //                     ),
    //                   ),
    //                   // if (listProgress[index] > 0 && listProgress[index] < 100)
    //                   CircularPercentIndicator(
    //                     radius: 30,
    //                     progressColor: cgreen,
    //                     percent: listFileUpload[index].intProgress!.toDouble() / 100,
    //                   ),
    //                   // GestureDetector(
    //                   //   onTap: () {
    //                   //     // listFile.removeAt(index);
    //                   //     // listProgress.removeAt(index);
    //                   //     // attachmentsList.removeAt(index);
    //                   //     listFileUpload.removeAt(index);
    //                   //     setState(() {});
    //                   //   },
    //                   //   child: Card(
    //                   //     child: Icon(Icons.delete_outline),
    //                   //   ),
    //                   // ),
    //                 ],
    //               ),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     constraints: BoxConstraints.loose(MediaQuery.of(context).size * h_05),
    //                     child: Text(
    //                       listFileUpload[index].strFileName!,
    //                       maxLines: 1,
    //                       overflow: TextOverflow.ellipsis,
    //                     ),
    //                   ),
    //                   Text(listFileUpload[index].strFileStatus!)
    //                 ],
    //               ),
    //               if (listFileUpload[index].intProgress == 100)
    //                 IconButton(
    //                     onPressed: () {
    //                       listFileUpload.removeAt(index);
    //                       setState(() {});
    //                     },
    //                     icon: Icon(Icons.delete_outline))
    //             ],
    //           ),
    //         ),
    //       );
    //     });
  }
}
