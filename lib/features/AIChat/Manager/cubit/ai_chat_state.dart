import 'package:edu_advisor/features/AIChat/models/message_model.dart';

class AiChatState {
  AiChatState({required List<MessageModel> messages, required this.isSending})
    : messages = List.unmodifiable(messages);
  final List<MessageModel> messages;
  final bool isSending;
  factory AiChatState.initial() {
    return AiChatState(
      messages: [
        MessageModel(
          text: "Hi! I'm your AI Academic Advisor.",
          sender: MessageSender.bot,
          time: DateTime.now(),
        ),
      ],
      isSending: false,
    );
  }

  AiChatState copyWith({List<MessageModel>? messages, bool? isSending}) {
    return AiChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }
}
