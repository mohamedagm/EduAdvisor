import 'package:edu_advisor/features/AIChat/Manager/cubit/ai_chat_state.dart';
import 'package:edu_advisor/features/AIChat/data/repo/ai_chat_repo.dart';
import 'package:edu_advisor/features/AIChat/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit({required AiChatRepo aiChatRepo})
    : _aiChatRepo = aiChatRepo,
      super(AiChatState.initial());

  final AiChatRepo _aiChatRepo;

  Future<void> sendMessage(String question) async {
    final trimmedQuestion = question.trim();
    if (trimmedQuestion.isEmpty || state.isSending) return;

    emit(
      state.copyWith(
        isSending: true,
        messages: [
          ...state.messages,
          MessageModel(
            text: trimmedQuestion,
            sender: MessageSender.user,
            time: DateTime.now(),
          ),
          MessageModel(
            text: 'Thinking...',
            sender: MessageSender.bot,
            time: DateTime.now(),
          ),
        ],
      ),
    );

    final result = await _aiChatRepo.askAdvisor(trimmedQuestion);

    if (isClosed) return;

    final reply = result.fold(
      (failure) =>
          "Sorry, I couldn't reach the academic advisor right now. ${failure.message}",
      (answer) => answer,
    );

    final updatedMessages = List<MessageModel>.from(state.messages);
    updatedMessages[updatedMessages.length - 1] = MessageModel(
      text: reply,
      sender: MessageSender.bot,
      time: DateTime.now(),
    );

    emit(state.copyWith(isSending: false, messages: updatedMessages));
  }
}
