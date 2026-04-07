import 'package:edu_advisor/features/AIChat/message_model.dart';
import 'package:edu_advisor/features/AIChat/views/widgets/ai_input_field.dart';
import 'package:edu_advisor/features/AIChat/views/widgets/header_ai_chat.dart';
import 'package:edu_advisor/features/AIChat/views/widgets/message_bubble.dart';
import 'package:edu_advisor/features/AIChat/views/widgets/quick_actions.dart';
import 'package:flutter/material.dart';

class AIChatView extends StatefulWidget {
  const AIChatView({super.key});

  @override
  State<AIChatView> createState() => _AIChatViewState();
}

class _AIChatViewState extends State<AIChatView> {
  final List<MessageModel> messages = [
    MessageModel(
      text: "Hi! I'm your AI Academic Advisor 👋",
      sender: MessageSender.bot,
      time: DateTime.now(),
    ),
  ];

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        MessageModel(
          text: controller.text,
          sender: MessageSender.user,
          time: DateTime.now(),
        ),
      );
    });

    controller.clear();

    /// simulate bot reply
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.add(
          MessageModel(
            text: "Based on your GPA, I recommend AI & ML courses 🤖",
            sender: MessageSender.bot,
            time: DateTime.now(),
          ),
        );
      });

      scrollToBottom();
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        message: messages[messages.length - 1 - index],
                      );
                    },
                  ),
                ),

                AiInputField(controller: controller, onSend: sendMessage),
              ],
            ),
            if (messages.length == 1)
              Positioned(
                top: 60,
                right: 20,
                left: 20,
                child: SizedBox(
                  height: 150,
                  child: QuickActions(
                    onActionTap: (action) {
                      controller.text = action;
                      sendMessage();
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
