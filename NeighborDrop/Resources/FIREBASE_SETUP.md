# FIREBASE SETUP -- Guide d'intégration rapide

## 🚀 Avant de commencer

Vous avez installé :
- ✅ `firebase_core`, `cloud_firestore`, `firebase_auth` dans `pubspec.yaml`
- ✅ Repository Firestore : `neighbordrop_repository_firestore.dart`
- ✅ Services Firebase : `firebase_service.dart`, `firebase_options.dart`
- ✅ Models mis à jour avec `toFirestore()` et `fromFirestore()`

Maintenant, configurons Firebase pour votre app.

---

## Étape 1 : Créer un projet Firebase

1. **Allez sur** https://console.firebase.google.com/
2. **Cliquez** "Add project"
3. **Nommez-le** "NeighborDrop" (ou votre préférence)
4. **Acceptez** les conditions et créez

---

## Étape 2 : Configurer FlutterFire

```bash
# Installer flutterfire_cli (une seule fois sur votre machine)
dart pub global activate flutterfire_cli

# Puis depuis le répertoire NeighborDrop :
cd /Users/hayuy/OneDrive/Bureau/Esilv/A4/S2/mobil\ design/NeighborDrop

# Configurer Firebase automatiquement
flutterfire configure
```

### ⚙️ Lors de la configuration, choisissez :
- **Platforms** : Android (et iOS si vous le souhaitez)
- **Project ID** : Votre projet Firebase
- **Service Account** : Acceptez par défaut

Cela créera automatiquement les fichiers de configuration.

---

## Étape 3 : Activer Firestore Database

1. Dans Firebase Console → Votre projet
2. **Allez à** `Firestore Database` (dans le menu de gauche)
3. **Cliquez** "Create Database"
4. **Mode de démarrage** : "Start in production mode"
5. **Région** : "`europe-west1` (Belgique/Pays-Bas)" OU votre région
6. **Créez**

---

## Étape 4 : Mettre à jour les règles Firestore

1. Dans Firestore → **Onglet "Rules"**
2. **Remplacez** le contenu par :

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Articles visibles par tous
    match /articles/{article=**} {
      allow read: if true;
      allow create, update: if request.auth != null;
      allow delete: if request.auth.uid == resource.data.ownerId;
    }
    
    // Profils utilisateurs
    match /users/{userId} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
    
    // Conversations
    match /conversations/{convId}/messages/{msgId} {
      allow read, write: if request.auth.uid in resource.parent.data().participants;
    }
  }
}
```

3. **Cliquez** "Publish"

---

## Étape 5 : Ajouter des données de test (optionnel)

### Via Firebase Console :
1. **Firestore** → Collections
2. **Créez une collection** `articles`
3. **Ajoutez des documents** avec cette structure :

```json
{
  "name": "VTT Orange",
  "category": "Sports",
  "size": "25kg",
  "description": "VTT enfant en bon état",
  "condition": "Bon état",
  "photoUrl": "https://images.unsplash.com/photo-...",
  "donorId": "user_001",
  "donorName": "Jean",
  "postalCode": "75012",
  "latitude": 48.8566,
  "longitude": 2.3522,
  "status": "available",
  "createdAt": "2026-03-23T10:30:00Z"
}
```

### OU via code Dart (automatisé)
Ajoutez cette fonction dans votre `main.dart` :

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedTestData() async {
  final db = FirebaseFirestore.instance;
  
  // Créer les articles
  await db.collection('articles').add({
    'name': 'VTT Orange',
    'category': 'Sports',
    'size': '25kg',
    'description': 'VTT enfant en excellent état',
    'condition': 'Bon état',
    'photoUrl': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64',
    'donorId': 'user_001',
    'donorName': 'Jean',
    'postalCode': '75012',
    'latitude': 48.8566,
    'longitude': 2.3522,
    'status': 'available',
    'createdAt': DateTime.now(),
  });
  
  // Créer les utilisateurs
  await db.collection('users').doc('user_001').set({
    'firstName': 'Jean',
    'lastName': 'Dupont',
    'photoUrl': 'https://ui-avatars.com/api/?name=Jean',
    'postalCode': '75012',
    'latitude': 48.8566,
    'longitude': 2.3522,
    'bio': 'Voisin bienveillant',
    'memberRating': 4.8,
    'memberSince': 2,
    'articlesPosted': 15,
    'exchangesCompleted': 12,
    'favorites': [],
    'createdAt': DateTime.now(),
  });
}
```

Puis appellez `seedTestData()` dans `main()` (une seule fois) :

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Seed les données de test (décommentez si première utilisation)
  // await seedTestData();
  
  runApp(const MyApp());
}
```

---

## Étape 6 : Utiliser Firestore dans l'App

### Initialiser Firebase dans `main.dart`

```dart
import 'package:firebase_core/firebase_core.dart';
import 'lib/core/services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}
```

### Utiliser le Repository dans un Controller

```dart
import 'package:get/get.dart';
import '../core/repositories/neighbordrop_repository_firestore.dart';
import '../core/models/article.dart';

class ArticlesListController extends GetxController {
  final repo = NeighbordropRepository();
  final articles = RxList<Article>();
  final isLoading = false.obs;
  
  @override
  void onInit() {
    loadArticles();
    super.onInit();
  }
  
  void loadArticles() async {
    isLoading.value = true;
    final data = await repo.getAllArticles();
    articles.assignAll(data);
    isLoading.value = false;
  }
}
```

---

## ✅ Vérifier que tout fonctionne

```bash
cd /chemin/vers/NeighborDrop

# 1. Installer les dépendances
flutter pub get

# 2. Nettoyer les caches
flutter clean

# 3. Lancer l'app
flutter run

# 4. Chercher les logs Firestore
# Vous devriez voir : "Successfully initialized Firebase"
```

---

## 🔧 Dépannage

| Problème | Solution |
|---------|----------|
| `Firebase not initialized` | Vérifiez que `Firebase.initializeApp()` est appelé en premier dans `main()` |
| `Permission denied` | Vérifiez les règles Firestore (onglet "Rules") |
| `Collection not found` | Créez la collection manuellement dans Firebase Console |
| `flutterfire configure` échoue | Assurez-vous que FlutterFire CLI est installé : `dart pub global activate flutterfire_cli` |

---

## 📚 Ressources

- **[Firebase Documentation](https://firebase.flutter.dev/)**
- **[Firestore Queries](https://firebase.google.com/docs/firestore/query-data/get-data)**
- **[FlutterFire CLI](https://firebase.flutter.dev/docs/cli)**
- **[Firestore Security Rules](https://firebase.google.com/docs/firestore/security/get-started)**

---

## 🎉 Vous êtes prêt !

L'app NeighborDrop stocke maintenant ses données dans Firestore et peut être scalée à des milliers d'utilisateurs ! 🚀

Pour ajouter l'authentification utilisateur, consultez :
→ `Firebase_Integration.md` section "Authentification"
