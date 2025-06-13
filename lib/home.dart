import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/chat_controller.dart';
import 'messages_screen.dart';

class Home extends StatelessWidget {
  Home({super.key}) {
    Get.put(ChatController());
  }

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: const Text(
          'Your AI Chat Assistant 🤖',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Expanded(child: MessagesScreen()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black12,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: 'Ask me anything...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () =>
                      controller.isLoading.value
                          ? const SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: IconButton(
                              onPressed: () {
                                controller.sendMessage(
                                  controller.textController.text,
                                );
                              },
                              icon: const Icon(Icons.send, color: Colors.white),
                            ),
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
