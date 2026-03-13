import 'package:dips/domain/ai_chat_repository/ai_chat_repository.dart';
import 'package:flutter/material.dart';

class ChatbotProvider extends ChangeNotifier {
  final AiChatRepository _aiChatRepository;
  ChatbotProvider(this._aiChatRepository);

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getChat(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    // 1. Add User Message
    _messages.add(ChatMessage(text: trimmed, isUser: true));
    controller.clear();
    _isLoading = true; // Show loading indicator
    notifyListeners();
    _scrollToBottom();

    try {
      final response = await _aiChatRepository.chatAi({"message": trimmed});
      
      _isLoading = false;
      if (response != null && response.containsKey("reply")) {
        _messages.add(ChatMessage(text: response["reply"], isUser: false));
      } else {
        _messages.add(ChatMessage(text: "Sorry, I couldn't process that.", isUser: false));
      }
    } catch (e) {
      _isLoading = false;
      _messages.add(ChatMessage(text: "Connection error. Please try again.", isUser: false));
    }

    notifyListeners();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}