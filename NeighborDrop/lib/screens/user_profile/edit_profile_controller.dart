import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/app_user.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';

class EditProfileController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  // Form controllers
  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;
  late final TextEditingController bioCtrl;
  late final TextEditingController postalCodeCtrl;

  final isSaving = false.obs;
  final selectedPhotoUrl = ''.obs;
  late AppUser _original;

  final formKey = GlobalKey<FormState>();

  // Avatars disponibles (pravatar.cc)
  static const List<String> avatarOptions = [
    'https://i.pravatar.cc/150?img=1',
    'https://i.pravatar.cc/150?img=2',
    'https://i.pravatar.cc/150?img=3',
    'https://i.pravatar.cc/150?img=4',
    'https://i.pravatar.cc/150?img=5',
    'https://i.pravatar.cc/150?img=6',
    'https://i.pravatar.cc/150?img=7',
    'https://i.pravatar.cc/150?img=8',
    'https://i.pravatar.cc/150?img=9',
    'https://i.pravatar.cc/150?img=10',
    'https://i.pravatar.cc/150?img=11',
    'https://i.pravatar.cc/150?img=12',
  ];

  @override
  void onInit() {
    super.onInit();
    _original = Get.arguments as AppUser;
    firstNameCtrl = TextEditingController(text: _original.firstName);
    lastNameCtrl = TextEditingController(text: _original.lastName);
    bioCtrl = TextEditingController(text: _original.bio);
    postalCodeCtrl = TextEditingController(text: _original.postalCode);
    selectedPhotoUrl.value = _original.photoUrl;
  }

  @override
  void onClose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    bioCtrl.dispose();
    postalCodeCtrl.dispose();
    super.onClose();
  }

  void pickAvatar(String url) {
    selectedPhotoUrl.value = url;
    Get.back(); // ferme le dialog
  }

  void showAvatarPicker(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choisir un avatar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: avatarOptions.length,
                itemBuilder: (_, i) {
                  final url = avatarOptions[i];
                  return Obx(() => GestureDetector(
                        onTap: () => pickAvatar(url),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedPhotoUrl.value == url
                                  ? const Color(0xFF2E7D32)
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(url),
                          ),
                        ),
                      ));
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Annuler'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    isSaving.value = true;
    try {
      final updated = _original.copyWith(
        firstName: firstNameCtrl.text.trim(),
        lastName: lastNameCtrl.text.trim(),
        bio: bioCtrl.text.trim(),
        postalCode: postalCodeCtrl.text.trim(),
        photoUrl: selectedPhotoUrl.value,
      );
      await repository.updateUser(updated);
      Get.back(result: updated);
      Get.snackbar(
        'Profil mis à jour',
        'Vos informations ont été enregistrées',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF2E7D32),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de sauvegarder le profil');
    } finally {
      isSaving.value = false;
    }
  }

  void cancel() => Get.back();
}
