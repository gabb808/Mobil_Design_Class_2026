# Configuration Firebase - Guide Pas à Pas

Guide détaillé pour configurer Firebase Firestore et permettre la synchronisation des données entre deux PC.

---

## 📋 Vue d'ensemble

**Objectif:** Configurer Firebase pour que les articles postés soient stockés dans le cloud et visibles sur tous les PC.

**Temps estimé:** 15-20 minutes

---

## ÉTAPE 1: Créer un projet Firebase

### 1.1 Aller sur Firebase Console
1. Ouvre [Firebase Console](https://console.firebase.google.com/)
2. Connecte-toi avec un compte Google

### 1.2 Créer un nouveau projet
1. Clique sur **"Créer un projet"**
2. Entre un nom: `NeighborDrop` (ou autre)
3. Accepte les conditions
4. Clique sur **"Créer un projet"** → Attends 30 secondes

### 1.3 Le projet est créé ✅
Tu dois voir un écran avec le logo Firebase et le nom de ton projet.

---

## ÉTAPE 2: Créer une application Android

### 2.1 Ajouter Firebase à ton app Android
1. Dans Firebase Console, clique sur l'icône **Android** (ou "Ajouter une app")
2. Remplis les champs:
   - **Nom du package Android:** `com.example.studymate`
   - **Alias de l'app (optionnel):** `NeighborDrop`

### 2.2 Télécharger google-services.json
1. Firebase te propose de télécharger un fichier `google-services.json`
2. **Clique sur "Télécharger"** → le fichier arrive dans tes Téléchargements

### 2.3 Placer le fichier au bon endroit
1. **Localisation:** `Mobil_Design_Class_2026/NeighborDrop/android/app/`
2. Copie le fichier `google-services.json` dans ce dossier
3. ✅ Check! Le fichier doit être exactement là: `android/app/google-services.json`

**💡 Besoin d'aide détaillée?** → Voir [INSTALL_GOOGLE_SERVICES_JSON.md](./INSTALL_GOOGLE_SERVICES_JSON.md)

---

## ÉTAPE 3: Récupérer les clés Firebase

### 3.1 Aller aux paramètres du projet
1. Dans Firebase Console, en haut à gauche clique sur **l'icône paramètres** ⚙️
2. Clique sur **"Paramètres du projet"**

### 3.2 Accéder à la clé API
1. Tu vois un onglet **"Paramètres"** → clique dessus
2. Descends jusqu'à **"Vos apps"** ou **"Applications"**
3. Tu dois voir ta config Android

### 3.3 Récupère les informations importantes
Tu dois avoir:
- **Project ID** (ex: `neighbordrop-12345`)
- **API Key** (une longue chaîne)
- **Messaging Sender ID**
- **App ID**

**💡 Astuce:** Fais une capture d'écran ou note ces valeurs quelque part!

---

## ÉTAPE 4: Configurer Firebase dans le code Flutter

### 4.1 Localiser le fichier de configuration
Chemin: `lib/core/services/firebase_options.dart`

### 4.2 Remplir les informations Android
Ouvre le fichier et trouve cette section:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',           // ← À REMPLIR
  appId: 'YOUR_ANDROID_APP_ID',              // ← À REMPLIR
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',  // ← À REMPLIR
  projectId: 'YOUR_PROJECT_ID',              // ← À REMPLIR
);
```

**Remplace les valeurs:**
- `YOUR_ANDROID_API_KEY` → Copie la clé API depuis Firebase
- `YOUR_ANDROID_APP_ID` → L'App ID Android
- `YOUR_MESSAGING_SENDER_ID` → Le Sender ID
- `YOUR_PROJECT_ID` → Le Project ID

**Exemple concret:**
```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyDzJxaB1C2d3E4f5G6h7I8j9K0lMnOpQrS',
  appId: '1:234567890:android:abcdef1234567890',
  messagingSenderId: '234567890',
  projectId: 'neighbordrop-12345',
);
```

### 4.3 Sauvegarder le fichier
**Ctrl+S** (ou Cmd+S sur Mac)

---

## ÉTAPE 5: Activer Firestore

### 5.1 Créer une base de données Firestore
1. Retourne à Firebase Console
2. Dans le menu de gauche, clique sur **"Firestore Database"**
3. Clique sur **"Créer une base de données"**

### 5.2 Configurer la base de données
1. **Mode:** Sélectionne **"Mode démarrage"** (plus permissif pour le développement)
2. **Localisation:** Choisis une région proche (ex: Europe)
3. Clique sur **"Créer"**

### 5.3 Configurer les règles de sécurité (important!)
1. Va dans l'onglet **"Règles"**
2. Remplace le texte par:

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Permet la lecture des articles
    match /articles/{document=**} {
      allow read: if true;
      allow write: if true;
    }
    // Permet la lecture/écriture des utilisateurs
    match /users/{document=**} {
      allow read: if true;
      allow write: if true;
    }
    // Permet la messagerie
    match /conversations/{document=**} {
      allow read: if true;
      allow write: if true;
    }
  }
}
```

3. Clique sur **"Publier"**

⚠️ **Note:** Ces règles sont très permissives pour le développement. À produire, les durcir!

---

## ÉTAPE 6: Tester la configuration

### 6.1 Nettoyer le projet Flutter
```bash
cd NeighborDrop
flutter clean
flutter pub get
```

### 6.2 Lancer l'app
```bash
flutter run
```

### 6.3 Vérifier que ça marche
1. L'app doit démarrer sans erreur Firebase
2. Poste un article sur l'app
3. Va dans Firebase Console → Firestore → Collection "articles"
4. Tu dois voir ton article aparecer! ✅

---

## ÉTAPE 7: Partager la configuration avec ta collègue

### 7.1 Les fichiers à partager
1. **`android/app/google-services.json`** → Elle le place dans le même dossier
2. **`lib/core/services/firebase_options.dart`** → Pousse-le sur GitHub avec `git push`

### 7.2 Elle n'a rien à faire sauf:
1. Cloner le repo: `git clone ...`
2. `flutter pub get`
3. `flutter run`

**C'est tout!** Les données Firebase seront directement synchronisées. ✅

---

## 🔍 Dépannage

### Erreur: "Project 'studymate' needs to be upgraded for accessing Cloud Firestore"
→ Va dans Firebase Console, Firestore Database, et clique sur "Créer une base de données"

### Erreur: "projectId is required"
→ Vérifie que tu as bien rempli `firebase_options.dart` avec les bonnes clés

### Articles ne s'affichent pas après posting
→ Vérifie que Firestore a bien la collection `articles` avec les données

---

## ✅ Checklist finale

- [ ] Projet Firebase créé
- [ ] App Android ajoutée au projet
- [ ] `google-services.json` placé dans `android/app/`
- [ ] `firebase_options.dart` rempli avec les clés
- [ ] Firestore Database créée
- [ ] Règles de sécurité configurées
- [ ] App testée et article posté ✅
- [ ] Configuration poussée sur GitHub

---

## 📞 Points de contact

- **Besoin d'aide?** Demande au prof ou sur Discord
- **Clés perdues?** Recréé simplement une nouvelle app Android dans Firebase

Bon codage! 🚀
