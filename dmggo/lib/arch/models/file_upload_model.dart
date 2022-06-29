import 'package:quickblox_sdk/models/qb_attachment.dart';

class FileUpload {
  String? strFilePath;
  String? strFileName;
  int? intProgress;
  String? strFileStatus;
  QBAttachment? attachment;
  FileUpload({this.strFilePath, this.strFileName, this.intProgress, this.attachment,this.strFileStatus});
}
