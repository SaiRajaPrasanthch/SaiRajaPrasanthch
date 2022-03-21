class ChatList {
  final bool isGroup;
  final bool? isImage;
  final String strName;
  final String? strText;
  final int? intUnreadMsg;

  ChatList({
    required this.isGroup,
    this.isImage,
    required this.strName,
    this.strText,
    this.intUnreadMsg,
  });
}
