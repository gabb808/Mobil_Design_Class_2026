import 'package:get/get.dart';

/// Service pour gérer l'ID utilisateur persistant dans la session
class UserSessionService extends GetxService {
  static const String _userIdKey = 'user_session_id';
  late String _currentUserId;

  /// Obtenir ou créer l'ID utilisateur pour cette session
  String get currentUserId => _currentUserId;

  @override
  void onInit() {
    super.onInit();
    // Créer un ID utilisateur cohérent pour la session actuelle
    _currentUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Réinitialiser l'ID (pour nouveau profil)
  void resetUserId() {
    _currentUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';
  }
}
