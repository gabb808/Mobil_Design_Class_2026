import 'package:get/get.dart';
import '../../core/models/app_user.dart';
import '../../core/repositories/neighbordrop_repository.dart';

class UserProfileController extends GetxController {
  final NeighbordropRepository repository = NeighbordropRepository();

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

  void goToMyArticles() {
    Get.snackbar('Info', 'Ecran non implementé pour le MVP');
  }

  void editProfile() {
    Get.snackbar('Info', 'Editer profil non implémenté pour le MVP');
  }

  void goBack() {
    Get.back();
  }

  void goToHome() {
    Get.offNamed('/');
  }
}
