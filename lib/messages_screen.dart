import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/chat_controller.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();
    final width = MediaQuery.of(context).size.width;

    return Obx(
      () => ListView.separated(
        reverse: true,
        itemBuilder: (context, index) {
          final message = controller.messages.reversed.toList()[index];
          final isUser = message['isUserMessage'];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                //  Chatbot Avatar
                if (!isUser)
                  const CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.smart_toy, color: Colors.white),
                  ),

                if (!isUser) const SizedBox(width: 8),

                //  Chat Bubble
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomRight: Radius.circular(isUser ? 0 : 20),
                        topLeft: Radius.circular(isUser ? 20 : 0),
                      ),
                      color:
                          isUser
                              ? Colors.grey.shade800
                              : Colors.deepPurple.shade700.withOpacity(0.9),
                    ),
                    constraints: BoxConstraints(maxWidth: width * 0.7),
                    child: Text(
                      message['message'].text.text[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                if (isUser) const SizedBox(width: 8),

                // Optional: User Avatar (if needed)
                // if (isUser)
                //   const CircleAvatar(
                //     backgroundColor: Colors.grey,
                //     child: Icon(Icons.person, color: Colors.white),
                //   ),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => const SizedBox(height: 4),
        itemCount: controller.messages.length,
      ),
    );
  }
}
