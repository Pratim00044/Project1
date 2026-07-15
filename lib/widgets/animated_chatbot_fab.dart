import 'package:flutter/material.dart';
import '../roles/chatbot_page.dart';

class AnimatedChatBotFAB extends StatefulWidget {
  const AnimatedChatBotFAB({super.key});

  @override
  State<AnimatedChatBotFAB> createState() => _AnimatedChatBotFABState();
}

class _AnimatedChatBotFABState extends State<AnimatedChatBotFAB> {
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    // Show fully on app open, then hide partially after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _isExpanded = false;
        });
      }
    });
  }

  void _handleTap() {
    if (!_isExpanded) {
      setState(() {
        _isExpanded = true;
      });
      // Hide again after 8 seconds if not clicked to go to chatbot
      Future.delayed(const Duration(seconds: 8), () {
        if (mounted) {
          setState(() {
            _isExpanded = false;
          });
        }
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatBotPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color goldColor = Color(0xFFD4AF37);
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(_isExpanded ? 0 : 40, 0, 0),
      child: GestureDetector(
        onTap: _handleTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: goldColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 15,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: const Icon(Icons.smart_toy_outlined, color: Colors.black, size: 30),
        ),
      ),
    );
  }
}
