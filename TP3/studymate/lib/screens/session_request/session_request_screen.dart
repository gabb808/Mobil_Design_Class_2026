import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/study_partner.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'session_request_controller.dart';

class SessionRequestScreen extends StatelessWidget {
  const SessionRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SessionRequestController>();
    final StudyPartner partner = Get.arguments as StudyPartner;
    controller.initWithPartner(partner);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Nouvelle session', style: AppTextStyles.cardTitle.copyWith(color: AppColors.surface)),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.surface),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        // Si la demande a ete envoyee
        if (controller.isSent.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.paddingStandard),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, size: 80, color: AppColors.success),
                  const SizedBox(height: 16),
                  Text('Demande envoyee !', style: AppTextStyles.screenTitle),
                  const SizedBox(height: 8),
                  Text(
                    'Votre demande de session avec ${partner.fullName} a bien ete envoyee.',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () => Get.offAllNamed('/'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
                        ),
                      ),
                      child: Text('Retour a l\'accueil', style: AppTextStyles.buttonText),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.paddingStandard),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Partenaire
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimens.borderRadiusCards),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(partner.photoUrl),
                      backgroundColor: AppColors.divider,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Avec :', style: AppTextStyles.bodySmall),
                        Text(partner.fullName, style: AppTextStyles.cardTitle),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.sectionSpacing),

              // Matiere
              Text('Matiere', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
                  border: Border.all(
                    color: controller.validationErrors.containsKey('subject')
                        ? AppColors.error
                        : AppColors.divider,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedSubject.value.isEmpty
                        ? null
                        : controller.selectedSubject.value,
                    hint: Text('Choisir une matiere', style: AppTextStyles.body),
                    isExpanded: true,
                    items: partner.subjects
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) controller.selectedSubject.value = v;
                    },
                  ),
                ),
              ),
              if (controller.validationErrors.containsKey('subject'))
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    controller.validationErrors['subject']!,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                  ),
                ),
              const SizedBox(height: AppDimens.sectionSpacing),

              // Creneau
              Text('Creneau', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
                  border: Border.all(
                    color: controller.validationErrors.containsKey('slot')
                        ? AppColors.error
                        : AppColors.divider,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedSlot.value.isEmpty
                        ? null
                        : controller.selectedSlot.value,
                    hint: Text('Choisir un creneau', style: AppTextStyles.body),
                    isExpanded: true,
                    items: partner.availabilities
                        .map((a) => DropdownMenuItem(
                              value: a.formatted,
                              child: Text(a.formatted),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) controller.selectedSlot.value = v;
                    },
                  ),
                ),
              ),
              if (controller.validationErrors.containsKey('slot'))
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    controller.validationErrors['slot']!,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                  ),
                ),
              const SizedBox(height: AppDimens.sectionSpacing),

              // Lieu
              Text('Lieu', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 8),
              _buildLocationOption(controller, 'bibliotheque', 'Bibliotheque', Icons.local_library),
              _buildLocationOption(controller, 'cafe', 'Cafe', Icons.coffee),
              _buildLocationOption(controller, 'en_ligne', 'En ligne', Icons.videocam),
              const SizedBox(height: AppDimens.sectionSpacing),

              // Message
              Text('Message personnalise', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 8),
              TextField(
                maxLines: 4,
                onChanged: (v) => controller.message.value = v,
                decoration: InputDecoration(
                  hintText: 'Ecrivez un message pour votre partenaire...',
                  hintStyle: AppTextStyles.body,
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
                    borderSide: BorderSide(
                      color: controller.validationErrors.containsKey('message')
                          ? AppColors.error
                          : AppColors.divider,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
                    borderSide: BorderSide(
                      color: controller.validationErrors.containsKey('message')
                          ? AppColors.error
                          : AppColors.divider,
                    ),
                  ),
                ),
              ),
              if (controller.validationErrors.containsKey('message'))
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    controller.validationErrors['message']!,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                  ),
                ),
              const SizedBox(height: 24),

              // Erreur d'envoi
              if (controller.hasError.value)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: AppColors.error, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Erreur lors de l\'envoi. Reessayez.',
                        style: AppTextStyles.body.copyWith(color: AppColors.error),
                      ),
                    ],
                  ),
                ),

              // Bouton Envoyer
              SizedBox(
                width: double.infinity,
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: controller.isSending.value ? null : controller.sendRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
                    ),
                  ),
                  child: controller.isSending.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.surface,
                            strokeWidth: 2,
                          ),
                        )
                      : Text('Envoyer ma demande', style: AppTextStyles.buttonText),
                ),
              ),
              const SizedBox(height: 12),

              // Bouton Annuler
              SizedBox(
                width: double.infinity,
                height: AppDimens.buttonHeight,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.divider),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
                    ),
                  ),
                  child: Text('Annuler', style: AppTextStyles.label),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLocationOption(
    SessionRequestController controller,
    String value,
    String label,
    IconData icon,
  ) {
    return Obx(() => GestureDetector(
          onTap: () => controller.selectedLocation.value = value,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: controller.selectedLocation.value == value
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
              border: Border.all(
                color: controller.selectedLocation.value == value
                    ? AppColors.primary
                    : AppColors.divider,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: controller.selectedLocation.value == value
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: AppTextStyles.label.copyWith(
                    color: controller.selectedLocation.value == value
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (controller.selectedLocation.value == value)
                  const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
              ],
            ),
          ),
        ));
  }
}
