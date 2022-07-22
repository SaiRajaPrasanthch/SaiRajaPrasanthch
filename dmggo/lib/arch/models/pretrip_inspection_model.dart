//PTIM - Pre Trip Inspection

class PTI {
  String strTitle;
  String? strSubTitle;
  int? isCheck;
  List<Condition> check;
  String? strStatus;
  String? strImage;
  String? strDescription;
  PTI({required this.strTitle, this.strSubTitle, this.isCheck, this.strStatus, this.strImage, required this.check,this.strDescription});
}

class Condition {
  String strPass;
  int intId;
  Condition({required this.strPass, required this.intId});
}
