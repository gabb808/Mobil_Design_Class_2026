import 'package:get/get.dart';
import '../../core/models/study_partner.dart';
import '../../core/repositories/studymate_repository.dart';

class PartnersListController extends GetxController {
  final StudymateRepository _repository = Get.find<StudymateRepository>();

  final RxList<StudyPartner> partnersList = <StudyPartner>[].obs;
  final RxList<StudyPartner> filteredList = <StudyPartner>[].obs;
  final RxString selectedSubject = 'Tous'.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  final List<String> subjects = [
    'Tous',
    'Mathematiques',
    'Informatique',
    'Physique',
    'Langues',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchPartners();
  }

  Future<void> fetchPartners() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      final partners = await _repository.fetchPartners();
      partnersList.assignAll(partners);
      _applyFilters();
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void filterBySubject(String subject) {
    selectedSubject.value = subject;
    _applyFilters();
  }

  void search(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void _applyFilters() {
    var result = List<StudyPartner>.from(partnersList);

    // Filtre par matiere
    if (selectedSubject.value != 'Tous') {
      result = result
          .where((p) =>
              p.mainSubject == selectedSubject.value ||
              p.subjects.contains(selectedSubject.value))
          .toList();
    }

    // Filtre par recherche
    if (searchQuery.value.isNotEmpty) {
      final q = searchQuery.value.toLowerCase();
      result = result
          .where((p) =>
              p.firstName.toLowerCase().contains(q) ||
              p.lastName.toLowerCase().contains(q) ||
              p.mainSubject.toLowerCase().contains(q) ||
              p.subjects.any((s) => s.toLowerCase().contains(q)))
          .toList();
    }

    filteredList.assignAll(result);
  }

  Future<void> toggleFavorite(String partnerId) async {
    await _repository.toggleFavorite(partnerId);
    // Mettre a jour l'etat local
    final index = partnersList.indexWhere((p) => p.id == partnerId);
    if (index != -1) {
      partnersList[index].isFavorite = !partnersList[index].isFavorite;
      partnersList.refresh();
      _applyFilters();
    }
  }
}
