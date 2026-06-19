import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/AIChat/Manager/cubit/ai_chat_cubit.dart';
import 'package:edu_advisor/features/AIChat/Manager/cubit/ai_chat_state.dart';
import 'package:edu_advisor/features/AIChat/data/datasources/ai_chat_remote_data_source.dart';
import 'package:edu_advisor/features/AIChat/data/models/ai_chat_request_model.dart';
import 'package:edu_advisor/features/AIChat/data/repo/ai_chat_repo.dart';
import 'package:edu_advisor/features/AIChat/views/widgets/ai_input_field.dart';
import 'package:edu_advisor/features/AIChat/views/widgets/header_ai_chat.dart';
import 'package:edu_advisor/features/AIChat/views/widgets/message_bubble.dart';
import 'package:edu_advisor/features/AIChat/views/widgets/quick_actions.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AIChatView extends StatelessWidget {
  const AIChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiChatCubit(
        aiChatRepo: AiChatRepo(
          remoteDataSource: AiChatRemoteDataSourceImpl(
            apiConsumer: DioConsumer(),
          ),
        ),
      ),
      child: const _AIChatViewBody(),
    );
  }
}

class _AIChatViewBody extends StatefulWidget {
  const _AIChatViewBody();

  @override
  State<_AIChatViewBody> createState() => _AIChatViewBodyState();
}

class _AIChatViewBodyState extends State<_AIChatViewBody> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void sendMessage(BuildContext context) {
    final question = controller.text.trim();
    if (question.isEmpty) return;

    final cubit = context.read<AiChatCubit>();
    if (cubit.state.isSending) return;

    final userState = context.read<CurrentUserCubit>().state;
    if (userState is! CurrentUserLoaded) {
      AppToast.error(
        context,
        title: 'User data unavailable',
        description: 'Please wait for your profile data to load.',
      );
      return;
    }

    final user = userState.user;
    final studentId = user.studentCode?.trim() ?? '';
    if (studentId.isEmpty) {
      AppToast.error(
        context,
        title: 'Student ID unavailable',
        description: 'Your student code is missing from your profile.',
      );
      return;
    }

    final request = AiChatRequestModel(
      studentId: studentId,
      studentContext:
          'Name: ${user.displayName} | GPA: ${user.displayGpa} | '
          'Major: ${user.displayDepartment} | Level: ${user.displayLevel}',
      question: question,
    );

    controller.clear();
    cubit.sendMessage(request);
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted || !scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiChatCubit, AiChatState>(
      listener: (context, state) => scrollToBottom(),
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    const HeaderAiChat(),
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        padding: const EdgeInsets.all(12),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          return MessageBubble(
                            message: state
                                .messages[state.messages.length - 1 - index],
                          );
                        },
                      ),
                    ),
                    AiInputField(
                      controller: controller,
                      onSend: () => sendMessage(context),
                      isLoading: state.isSending,
                    ),
                  ],
                ),
                if (state.messages.length == 1 && !state.isSending)
                  Positioned(
                    top: 60,
                    right: 20,
                    left: 20,
                    child: SizedBox(
                      height: 150,
                      child: QuickActions(
                        onActionTap: (action) {
                          controller.text = action;
                          sendMessage(context);
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
