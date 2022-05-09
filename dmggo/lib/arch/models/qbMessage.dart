import 'package:quickblox_sdk/models/qb_attachment.dart';

class QBMessageLocal {
  String? id;
  List<QBAttachment?>? attachments;
  Map<String, String>? properties;
  int? dateSent;
  int? senderId;
  int? recipientId;
  List<int>? readIds;
  List<int>? deliveredIds;
  String? dialogId;
  bool? markable;
  bool? delayed;
  String? body;
}
