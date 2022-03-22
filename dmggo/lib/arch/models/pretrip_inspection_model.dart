//PTIM - Pre Trip Inspection

class PTI {
  String strTitle;
  String? strSubTitle;
  bool? isCheck;
  Check check;
  String? strStatus;
  String? strImage;
  PTI(
      {required this.strTitle,
      this.strSubTitle,
      this.isCheck,
      this.strStatus,
      this.strImage,
      required this.check});
}

class Check {
  String strPass;
  String strFail;
  Check({required this.strPass, required this.strFail});
}
