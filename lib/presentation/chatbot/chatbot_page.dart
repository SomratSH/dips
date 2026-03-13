import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'chatbot_provider.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatbotProvider>();
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.red),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Scan2Home Assistant",
          style: TextStyle(color: Color(0xFF041E41), fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: provider.scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: provider.messages.length + (provider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.messages.length) {
                   return const Align(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Text("Assistant is typing...", style: TextStyle(fontSize: 12, color: Colors.grey)),
                     ),
                   );
                }
                return ChatBubble(message: provider.messages[index]);
              },
            ),
          ),

          // Quick Actions
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _QuickChip(text: "What is Land law?", onTap: () => provider.getChat("What is Land law?")),
                const SizedBox(width: 8),
                _QuickChip(text: "Pricing", onTap: () => provider.getChat("Tell me about pricing")),
                const SizedBox(width: 8),
                _QuickChip(text: "FAQs", onTap: () => provider.getChat("Show me FAQs")),
              ],
            ),
          ),

          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: provider.controller,
                      decoration: InputDecoration(
                        hintText: "Type your message here...",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        filled: true,
                        fillColor: const Color(0xFFF0F2F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => provider.getChat(provider.controller.text),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFF0B1E4A),
                      child: Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _QuickChip({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF041E41))),
      backgroundColor: Colors.white,
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
    );
  }
}


class ChatBubble extends StatelessWidget {
  final dynamic message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: message.isUser ? const Color(0xFF0B1E4A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6)],
        ),
        child: message.isUser
            ? Text(message.text, style: const TextStyle(color: Colors.white))
            : TypingText(
                text: message.text,
                style: const TextStyle(color: Colors.black87, height: 1.4),
              ),
      ),
    );
  }
}

class TypingText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration speed;

  const TypingText({
    super.key,
    required this.text,
    this.style,
    this.speed = const Duration(milliseconds: 30),
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  String _displayedText = "";
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_index < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_index];
          _index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayedText, style: widget.style);
  }
}
