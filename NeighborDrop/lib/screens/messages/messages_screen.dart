import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import 'messages_controller.dart';

class MessagesScreen extends GetView<MessagesController> {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => controller.goBack(),
        ),
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.messages.isEmpty) {
                return const Center(child: Text('Aucun message'));
              }
              return ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[controller.messages.length - 1 - index];
                  final isMine = msg['senderId'] == controller.userSessionService.currentUserId;
                  return Align(
                    alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isMine ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg['content'] ?? '',
                        style: TextStyle(
                          color: isMine ? Colors.white : AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageText,
                    decoration: InputDecoration(
                      hintText: 'Votre message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() {
                  return IconButton(
                    icon: Icon(
                      Icons.send,
                      color: controller.isSending.value ? Colors.grey : AppColors.primary,
                    ),
                    onPressed: controller.isSending.value ? null : controller.sendMessage,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
