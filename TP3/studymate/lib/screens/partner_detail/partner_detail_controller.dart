import 'package:get/get.dart';
import '../../core/models/study_partner.dart';
import '../../core/models/review.dart';
import '../../core/repositories/studymate_repository.dart';

class PartnerDetailController extends GetxController {
  final StudymateRepository _repository = Get.find<StudymateRepository>();

  final Rx<StudyPartner?> partner = Rx<StudyPartner?>(null);
  final RxList<Review> reviews = <Review>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  Future<void> loadPartnerDetail(String partnerId) async {
    isLoading.value = true;
    hasError.value = false;
    try {
      final result = await _repository.getPartnerDetail(partnerId);
      partner.value = result;

      final reviewResult = await _repository.getReviews(partnerId);
      reviews.assignAll(reviewResult);
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    if (partner.value == null) return;
    await _repository.toggleFavorite(partner.value!.id);
    partner.value!.isFavorite = !partner.value!.isFavorite;
    partner.refresh();
  }
}
