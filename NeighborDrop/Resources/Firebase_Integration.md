# FIREBASE INTEGRATION -- NeighborDrop

## Vue d'ensemble
NeighborDrop utilise **Firebase/Firestore** comme backend de stockage de données. Cela remplace les données mockées précédentes et permet :
- Persistance réelle des données
- Synchronisation en temps réel
- Gestion des utilisateurs avec Firebase Auth
- Scalabilité cloud-native

---

## Configuration Firebase

### 1. Créer un projet Firebase
1. Allez sur [Firebase Console](https://console.firebase.google.com/)
2. Cliquez sur "Add project" et nommez-le
3. Activez Firestore Database et Authentication

### 2. Configurer Android
```bash
# Installer flutterfire_cli (un seul fois)
dart pub global activate flutterfire_cli

# Depuis le répertoire NeighborDrop
flutterfire configure
```

Sélectionnez :
- Android
- Votre projet Firebase
- Acceptez les modifications

Cela crée automatiquement `firebase_options.dart` avec vos clés.

### 3. Dépendances installées
```yaml
firebase_core: ^2.24.2
cloud_firestore: ^4.13.6
firebase_auth: ^4.11.0
```

---

## Structure Firestore

### Collections

#### `articles`
```json
{
  "id": "art_001",
  "name": "VTT Orange",
  "category": "Sports",
  "size": "25kg",
  "description": "VTT enfant en bon état...",
  "condition": "Bon état",
  "photoUrl": "https://...",
  "donorId": "user_001",
  "donorName": "Jean",
  "donorPhotoUrl": "https://...",
  "postalCode": "75012",
  "latitude": 48.8566,
  "longitude": 2.3522,
  "status": "available",
  "createdAt": 2026-03-23T10:30:00Z,
  "updatedAt": 2026-03-23T10:30:00Z
}
```

#### `users`
```json
{
  "firstName": "Jean",
  "lastName": "Dupont",
  "photoUrl": "https://...",
  "postalCode": "75012",
  "latitude": 48.8566,
  "longitude": 2.3522,
  "bio": "Voisin aidant et bienveillant...",
  "memberRating": 4.8,
  "memberSince": 2,
  "articlesPosted": 15,
  "exchangesCompleted": 12,
  "favorites": ["art_001", "art_005"],
  "createdAt": 2023-01-15T09:00:00Z,
  "updatedAt": 2026-03-23T10:30:00Z
}
```

#### `conversations/{conversationId}/messages`
```json
{
  "senderId": "user_001",
  "content": "Bonjour, je suis intéressé par ce VTT!",
  "timestamp": 2026-03-23T10:35:00Z
}
```

---

## Utilisation dans l'App

### 1. Initialiser Firebase dans main.dart
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

### 2. Utiliser le Repository
```dart
final repo = NeighbordropRepository();

// Récupérer tous les articles
final articles = await repo.getAllArticles();

// Créer un nouvel article
await repo.createArticle(article);

// Filtrer par catégorie
final filtered = await repo.filterByCategory('Sports');

// Ajouter aux favoris
await repo.addToFavorites(userId, articleId);
```

### 3. Models avec Firestore
```dart
// Créer depuis Firestore
final article = Article.fromFirestore(doc);

// Sauvegarder dans Firestore
final data = article.toFirestore();

// Créer depuis JSON (import)
final article = Article.fromJson(jsonData);
```

---

## Règles de Sécurité Firestore (rules.txt)

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Articles visibles par tous
    match /articles/{document=**} {
      allow read: if true;
      allow create, update: if request.auth != null;
      allow delete: if request.auth.uid == resource.data.ownerId;
    }
    
    // Profils
    match /users/{userId} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
    
    // Conversations privées
    match /conversations/{convId}/messages/{msgId} {
      allow read, write: if request.auth.uid in resource.parent.data().participants;
    }
  }
}
```

À copier dans Firebase Console → Firestore → Rules

---

## Migration de Données Mock → Firestore

### Garder les données mockées comme fallback
```dart
// Dans le repository
Future<List<Article>> getAllArticles() async {
  try {
    return await _firestoreGetArticles();
  } catch (e) {
    print('Fallback aux données mockées');
    return _mockArticles;
  }
}
```

### Importer les données mockées
```bash
# Script pour seeder Firebase avec les données mockées
flutter pub run intl:messages --no-use-deferred-loading
```

---

## Commandes Utiles

```bash
# Réinitialiser la configuration Firebase
flutterfire configure --overwrite

# Voir les logs Firestore
adb logcat | grep -i firestore

# Générer les fichiers (si manquants)
flutter pub get
flutter clean
flutter pub get
```

---

## Améliorations Futures

1. **Authentification** : Ajouter `firebase_auth` pour créer des comptes utilisateur
2. **Storage** : `firebase_storage` pour uploader des photos
3. **Real-time** : `StreamBuilder` pour les mises à jour live
4. **Pagination** : `.limit(20).startAfter()` pour charger plus d'articles
5. **Recherche** : Algolia ou Elasticsearch intégré à Firebase

---

## Troubleshooting

### ❌ `MissingPluginException`
→ Problème d'initialisation Firebase
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### ❌ `PermissionDenied`
→ Vérifier les règles Firestore

### ❌ `credentials.json not found`
→ Relancer `flutterfire configure`

---

## Ressources

- [Firebase Documentation](https://firebase.flutter.dev/)
- [Firestore Best Practices](https://firebase.google.com/docs/firestore/best-practices)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli)
