import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'message': 'Hello! I am your Statixa assistant. How can I help you today?',
      'isMe': false,
      'time': '10:00 AM'
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'message': _messageController.text,
        'isMe': true,
        'time': '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}'
      });
      _messageController.clear();
    });

    // Simulate bot response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'message': 'Thanks for your message. I am currently in training mode, but I will record your query!',
            'isMe': false,
            'time': '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}'
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: goldColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_outlined, color: goldColor, size: 20),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('STATIXA AI',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1)),
                Text('Always active',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final bool isMe = msg['isMe'];
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isMe ? goldColor : surfaceColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(isMe ? 20 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['message'],
                          style: TextStyle(
                            color: isMe ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: isMe ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg['time'],
                          style: TextStyle(
                            color: isMe ? Colors.black.withValues(alpha: 0.4) : Colors.white38,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D0D),
        border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Type your question...',
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: goldColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded, color: Colors.black, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
