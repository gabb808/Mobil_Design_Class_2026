# Installation de google-services.json

Guide simple pour installer le fichier Firebase sur Android.

---

## 📍 Emplacement EXACT du fichier

### Structure de dossiers:
```
NeighborDrop/
├── android/
│   ├── app/
│   │   ├── build.gradle
│   │   ├── google-services.json    ← LE FICHIER VA ICI!
│   │   └── src/
│   ├── build.gradle
│   └── ...
├── ios/
├── lib/
├── pubspec.yaml
└── ...
```

**Chemin complet:** `Mobil_Design_Class_2026/NeighborDrop/android/app/google-services.json`

---

## 🔽 Étape 1: Télécharger le fichier depuis Firebase

### 1.1 Va dans Firebase Console
- Ouvre [Firebase Console](https://console.firebase.google.com/)
- Sélectionne ton projet

### 1.2 Ajoute une app Android (si pas encore faite)
1. Clique sur **"Ajouter une app"** ou l'icône **Android**
2. Remplis:
   - **Nom du package Android:** `com.example.studymate`
   - **Alias (optionnel):** `NeighborDrop`
3. Clique **"Enregistrer l'app"**

### 1.3 Télécharge le fichier
1. Firebase t'affiche: **"Télécharger google-services.json"**
2. Clique sur **"Télécharger"**
3. Le fichier arrive dans tes **Téléchargements**

---

## 📁 Étape 2: Placer le fichier au bon endroit

### Méthode 1: Avec l'Explorateur Windows (la plus simple)

1. **Ouvre l'Explorateur Windows** (Win+E)
2. **Va au dossier:** `Mobil_Design_Class_2026\NeighborDrop\android\app\`
3. **Copie-colle** le fichier `google-services.json` que tu viens de télécharger ici
4. ✅ Le fichier doit être maintenant visible

### Méthode 2: Avec VS Code

1. Ouvre VS Code avec le projet
2. À gauche, dans l'Explorateur, va jusqu'à `android/app/`
3. Fais **clic-droit** → **"Révéler dans l'Explorateur"**
4. Copie-colle `google-services.json` ici

### Méthode 3: Avec le Terminal

```bash
# Depuis le dossier NeighborDrop
copy %USERPROFILE%\Downloads\google-services.json android\app\
```

---

## ✅ Vérifier que c'est installé

### Vérifier dans VS Code
1. Ouvre l'explorateur VS Code
2. Va dans `android/app/`
3. Tu dois voir `google-services.json` dans la liste ✅

### Vérifier dans l'Explorateur
1. Ouvre `Mobil_Design_Class_2026\NeighborDrop\android\app\`
2. Cherche `google-services.json`
3. Il doit être visible ✅

---

## ⚙️ Étape 3: Configuration dans Flutter

### Vérifier build.gradle

Ouvre le fichier `android/build.gradle` et cherche:

```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.3.15'  // ← Doit être présent
}
```

Si ce n'est pas là, ajoute-le.

### Vérifier app/build.gradle

Ouvre `android/app/build.gradle` et cherche à la fin:

```gradle
apply plugin: 'com.google.gms.google-services'  // ← Doit être à la fin
```

Si ce n'est pas là, ajoute cette ligne à la fin du fichier.

---

## 🚀 Étape 4: Tester

### Nettoie et relance
```bash
cd NeighborDrop
flutter clean
flutter pub get
flutter run
```

### L'app doit démarrer sans erreur Firebase ✅

---

## 🐛 Dépannage

### Erreur: "google_services plugin not found"
→ Ajoute `apply plugin: 'com.google.gms.google-services'` à la fin de `android/app/build.gradle`

### Erreur: "Failed to parse JSON in google-services.json"
→ Vérifie que le fichier n'est pas corrompu. Télécharge-le à nouveau depuis Firebase.

### Le fichier n'appelle pas Firestore
→ Vérifie que:
1. Le fichier est dans `android/app/` (exact!)
2. Les clés sont remplies dans `lib/core/services/firebase_options.dart`

### "Project needs to be upgraded for Firestore"
→ Va dans Firebase Console et crée une base Firestore

---

## 📋 Checklist finale

- [ ] Fichier téléchargé depuis Firebase
- [ ] Copié dans `android/app/google-services.json`
- [ ] Fichier visible dans l'Explorateur
- [ ] `build.gradle` contient les dépendances Google Services
- [ ] `app/build.gradle` a `apply plugin: 'com.google.gms.google-services'`
- [ ] `flutter clean` + `flutter pub get` fait
- [ ] App lancée sans erreur ✅

C'est bon! 🎉
