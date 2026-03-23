import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import 'conversations_controller.dart';

class ConversationsScreen extends GetView<ConversationsController> {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.primary,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.conversations.isEmpty) {
          return const Center(
            child: Text('Aucune conversation'),
          );
        }

        return ListView.separated(
          itemCount: controller.conversations.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final conv = controller.conversations[index];
            return ListTile(
              title: Text('Conversation ${index + 1}'),
              subtitle: Text('${(conv['participants'] as List?)?.length ?? 2} participants'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => controller.openConversation(conv),
            );
          },
        );
      }),
    );
  }
}
