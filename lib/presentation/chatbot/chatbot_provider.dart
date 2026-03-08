import 'dart:async';
import 'package:dips/domain/ai_chat_repository/ai_chat_repository.dart';
import 'package:flutter/material.dart';


class ChatbotProvider extends ChangeNotifier {
  AiChatRepository _aiChatRepository;

  ChatbotProvider(this._aiChatRepository);

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<_Message> _messages = [];
  List<_Message> get messages => _messages;

  Future<void> getChat(String text) async {
    final response = await _aiChatRepository.chatAi({"message": text});

    if (response.isNotEmpty) {
      sendMessage(response["reply"]);
    }
  }

  void sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    _messages.add(_Message(text: trimmed, isUser: true));
    controller.clear();
    notifyListeners();
    _scrollToBottom();

    // Fake bot response
    Timer(const Duration(seconds: 1), () {
      _messages.add(_Message(text: text, isUser: false));
      notifyListeners();
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

class _Message {
  final String text;
  final bool isUser;

  _Message({required this.text, required this.isUser});
}
