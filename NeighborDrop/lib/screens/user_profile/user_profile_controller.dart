import 'package:get/get.dart';
import '../../core/models/app_user.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';
import '../../core/services/user_session_service.dart';

class UserProfileController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final user = Rxn<AppUser>();
  final isLoading = false.obs;
  final isCurrentUser = true.obs;

  @override
  void onInit() {
    super.onInit();
    final String? userId = Get.arguments;
    loadUser(userId);
  }

  Future<void> loadUser([String? userId]) async {
    isLoading.value = true;
    try {
      final userSessionService = Get.find<UserSessionService>();
      final currentUserId = userSessionService.currentUserId;
      
      if (userId != null && userId != currentUserId) {
        // Load a different user's profile
        user.value = await repository.getUserById(userId);
        isCurrentUser.value = false;
      } else {
        // Load current user's profile
        user.value = await repository.getUserById(currentUserId);
        isCurrentUser.value = true;
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger le profil: $e');
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
