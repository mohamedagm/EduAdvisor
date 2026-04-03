enum MessageSender { user, bot }

class MessageModel {
  final String text;
  final MessageSender sender;
  final DateTime time;

  MessageModel({required this.text, required this.sender, required this.time});
}
