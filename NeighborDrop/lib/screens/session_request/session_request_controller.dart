import 'package:get/get.dart';
import '../../core/models/session_request.dart';
import '../../core/models/study_partner.dart';
import '../../core/repositories/studymate_repository.dart';

class SessionRequestController extends GetxController {
  final StudymateRepository _repository = Get.find<StudymateRepository>();

  late StudyPartner partner;

  final RxString selectedSubject = ''.obs;
  final RxString selectedSlot = ''.obs;
  final RxString selectedLocation = 'bibliotheque'.obs;
  final RxString message = ''.obs;
  final RxBool isSending = false.obs;
  final RxBool isSent = false.obs;
  final RxBool hasError = false.obs;
  final RxMap<String, String> validationErrors = <String, String>{}.obs;

  void initWithPartner(StudyPartner p) {
    partner = p;
    if (p.subjects.isNotEmpty) {
      selectedSubject.value = p.subjects.first;
    }
    if (p.availabilities.isNotEmpty) {
      selectedSlot.value = p.availabilities.first.formatted;
    }
  }

  bool validate() {
    validationErrors.clear();
    if (selectedSubject.value.isEmpty) {
      validationErrors['subject'] = 'Veuillez choisir une matiere';
    }
    if (selectedSlot.value.isEmpty) {
      validationErrors['slot'] = 'Veuillez choisir un creneau';
    }
    if (message.value.trim().isEmpty) {
      validationErrors['message'] = 'Veuillez ecrire un message';
    }
    return validationErrors.isEmpty;
  }

  Future<void> sendRequest() async {
    if (!validate()) return;

    isSending.value = true;
    hasError.value = false;

    try {
      final request = SessionRequest(
        id: 'req_${DateTime.now().millisecondsSinceEpoch}',
        partnerId: partner.id,
        partnerName: partner.fullName,
        subject: selectedSubject.value,
        timeSlot: selectedSlot.value,
        location: selectedLocation.value,
        message: message.value.trim(),
      );

      final success = await _repository.sendSessionRequest(request);
      if (success) {
        isSent.value = true;
      } else {
        hasError.value = true;
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isSending.value = false;
    }
  }
}
