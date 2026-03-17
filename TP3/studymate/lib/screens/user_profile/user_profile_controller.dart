import 'package:get/get.dart';
import '../../core/models/app_user.dart';
import '../../core/repositories/neighbordrop_repository.dart';

class UserProfileController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final user = Rxn<AppUser>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    isLoading.value = true;
    try {
      final currentUser = await repository.getCurrentUser();
      user.value = currentUser;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger le profil');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editProfile() async {
    if (user.value == null) return;
    // Navigate to edit screen and wait for the updated user returned via Get.back(result: updated)
    final updated = await Get.toNamed('/edit-profile', arguments: user.value);
    if (updated is AppUser) {
      user.value = updated;
    }
  }

  void goToMyArticles() {
    Get.toNamed('/my-articles');
  }
}
