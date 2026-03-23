import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'conversations_controller.dart';

class ConversationsScreen extends GetView<ConversationsController> {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'Messages',
          style: AppTextStyles.heading2.copyWith(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.conversations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.forum_outlined,
                  size: 72,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: AppDimens.paddingM),
                Text(
                  'Aucune conversation',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppDimens.paddingS),
                Text(
                  'Contactez un voisin depuis une annonce\npour démarrer une conversation',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.loadConversations,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingS),
            itemCount: controller.conversations.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: AppColors.divider,
              indent: 80,
            ),
            itemBuilder: (context, index) {
              final conversation = controller.conversations[index];
              return ListTile(
                title: Text('Conversation ${index + 1}'),
                subtitle: Text('${(conversation['participants'] as List?)?.length ?? 2} participants'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => controller.openConversation(conversation),
              );
            },
          ),
        );
      }),
    );
  }
}
