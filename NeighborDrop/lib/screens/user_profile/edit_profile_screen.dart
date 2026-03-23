import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => controller.cancel(),
        ),
        title: Text(
          'Modifier le profil',
          style: AppTextStyles.heading2.copyWith(color: Colors.white),
        ),
        actions: [
          Obx(() => controller.isSaving.value
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5),
                  ),
                )
              : TextButton(
                  onPressed: controller.saveProfile,
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )),
        ],
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.paddingM),
          children: [
            // Avatar section
            _buildAvatarSection(context),

            const SizedBox(height: AppDimens.paddingL),

            // Section identité
            _buildSectionTitle('Identité'),
            const SizedBox(height: AppDimens.paddingS),
            _buildField(
              label: 'Prénom',
              controller: controller.firstNameCtrl,
              icon: Icons.person_outline,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Requis' : null,
            ),
            const SizedBox(height: AppDimens.paddingM),
            _buildField(
              label: 'Nom',
              controller: controller.lastNameCtrl,
              icon: Icons.person_outline,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Requis' : null,
            ),

            const SizedBox(height: AppDimens.paddingL),

            // Section localisation
            _buildSectionTitle('Localisation'),
            const SizedBox(height: AppDimens.paddingS),
            _buildField(
              label: 'Code postal',
              controller: controller.postalCodeCtrl,
              icon: Icons.location_on_outlined,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Requis';
                if (v.trim().length != 5) return '5 chiffres requis';
                return null;
              },
            ),

            const SizedBox(height: AppDimens.paddingL),

            // Section à propos
            _buildSectionTitle('À propos de moi'),
            const SizedBox(height: AppDimens.paddingS),
            _buildField(
              label: 'Bio',
              controller: controller.bioCtrl,
              icon: Icons.edit_note_outlined,
              maxLines: 4,
              hint: 'Parlez-vous en quelques mots...',
              validator: null,
            ),

            const SizedBox(height: AppDimens.paddingL),

            // Save button at bottom
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.paddingM),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.borderRadiusButtons),
                      ),
                    ),
                    onPressed: controller.isSaving.value
                        ? null
                        : controller.saveProfile,
                    child: controller.isSaving.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5))
                        : const Text(
                            'Enregistrer les modifications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                )),

            const SizedBox(height: AppDimens.paddingL),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context) {
    return Center(
      child: Obx(() => GestureDetector(
            onTap: () => controller.showAvatarPicker(context),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage:
                      NetworkImage(controller.selectedPhotoUrl.value),
                  backgroundColor: AppColors.divider,
                  onBackgroundImageError: (_, __) {},
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          )),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingM, vertical: AppDimens.paddingM),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
