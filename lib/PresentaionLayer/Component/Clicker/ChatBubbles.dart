import 'package:flutter/material.dart';

class ChatBubbles extends StatelessWidget {
  final String messages;
  const ChatBubbles({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32)),
          color: Theme.of(context).colorScheme.inversePrimary),
      child: Text(
        messages,
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
