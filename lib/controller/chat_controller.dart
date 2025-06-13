import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final messages = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  DialogFlowtter? dialogFlowtter;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeDialogFlow();
  }

  Future<void> initializeDialogFlow() async {
    try {
      dialogFlowtter = await DialogFlowtter.fromFile(
        path: "assets/dialogflow_auth.json",
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to initialize Dialogflow: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty || dialogFlowtter == null) return;

    // Add user message
    addMessage(Message(text: DialogText(text: [text])), true);
    textController.clear();

    isLoading.value = true;

    try {
      final response = await dialogFlowtter!.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)),
      );

      if (response.message != null) {
        addMessage(response.message!);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get response: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(
        'Error'
        'Failed to get response: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  @override
  void onClose() {
    textController.dispose();
    dialogFlowtter?.dispose();
    super.onClose();
  }
}
