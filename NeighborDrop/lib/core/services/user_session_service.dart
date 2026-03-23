import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service pour gérer l'ID utilisateur persistant dans la session
class UserSessionService extends GetxService {
  static const String _userIdKey = 'user_session_id';
  late String _currentUserId;
  late SharedPreferences _prefs;

  /// Obtenir ou créer l'ID utilisateur pour cette session
  String get currentUserId => _currentUserId;

  @override
  Future<UserSessionService> onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    
    // Essayer de charger l'ID utilisateur stocké
    final storedUserId = _prefs.getString(_userIdKey);
    if (storedUserId != null && storedUserId.isNotEmpty) {
      _currentUserId = storedUserId;
    } else {
      // Créer un nouvel ID utilisateur pour la session
      _currentUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      await _prefs.setString(_userIdKey, _currentUserId);
    }
    return this;
  }

  /// Réinitialiser l'ID (pour nouveau profil)
  void resetUserId() {
    _currentUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    _prefs.setString(_userIdKey, _currentUserId);
  }

  /// Définir un ID utilisateur spécifique (après connexion/création)
  void setCurrentUserId(String userId) {
    _currentUserId = userId;
    _prefs.setString(_userIdKey, userId);
  }
}
