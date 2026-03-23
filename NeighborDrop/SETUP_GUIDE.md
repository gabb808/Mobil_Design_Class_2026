# Guide d'Installation - NeighborDrop

Ce guide explique comment configurer le projet Flutter **NeighborDrop** sur un nouveau PC.

## ⚙️ Prérequis

Avant de commencer, assurez-vous d'avoir installé:

### 1. **Flutter SDK** (requis)
- [Télécharger Flutter](https://flutter.dev/docs/get-started/install)
- Vérifier l'installation: `flutter --version`
- Vérifier les dépendances: `flutter doctor`

### 2. **Android Studio / Xcode** (pour émuler l'app)
- Android Studio pour tester sur **Android**
- Xcode pour tester sur **iOS** (Mac seulement)

### 3. **Git** (pour cloner le projet)
- [Télécharger Git](https://git-scm.com/)

---

## 📥 Installation du projet

### Étape 1: Cloner le repository
```bash
git clone https://github.com/gabb808/Mobil_Design_Class_2026.git
cd Mobil_Design_Class_2026/NeighborDrop
```

### Étape 2: Installer les dépendances Flutter
```bash
flutter pub get
```

---

## 🔥 Configuration Firebase (IMPORTANT!)

Le projet utilise **Firebase Firestore** pour stocker les articles de manière persistante.

**📖 Guide détaillé disponible:** [FIREBASE_CONFIG_STEPS.md](./FIREBASE_CONFIG_STEPS.md)

### Résumé rapide:
1. Créer un projet Firebase
2. Télécharger `google-services.json` → placer dans `android/app/`
3. Remplir les clés dans `lib/core/services/firebase_options.dart`
4. Créer une base Firestore
5. Tester en postant un article

**Voir le fichier FIREBASE_CONFIG_STEPS.md pour les détails complets et visuels!**

---

## ✅ Vérification de la configuration

Avant de lancer l'app, vérifie que tout est bon:

```bash
flutter pub get
flutter doctor -v
```

Aucune erreur? Parfait! ✅

---

## 🚀 Lancer l'application

### Sur un émulateur Android:
```bash
flutter run
```

### Sur un appareil Android connecté:
```bash
flutter run
```

### Sur iPhone (Mac seulement):
```bash
flutter run -d ios
```

---

## 🔐 Notes de sécurité

⚠️ **NE COMMIT PAS les clés Firebase!**
- Le fichier `.gitignore` protège déjà les fichiers sensibles
- Mais sois prudente si tu modifies `.gitignore`

---

## 📱 Données partagées

Tous les articles postés sont maintenant stockés dans **Firebase Firestore**:
- ✅ Visible partout (sur tous les PC)
- ✅ Persistant (ne disparait pas au redémarrage)
- ✅ En temps réel (mises à jour instantanées)

---

## ❓ Problèmes courants

### "flutter: command not found"
→ Flutter n'est pas dans le PATH. Réinstalle Flutter et ajoute-le au PATH.

### Erreur Firebase: "projectId is required"
→ Les clés Firebase ne sont pas configurées correctement. Mets à jour `firebase_options.dart`.

### Erreur Gradle (Android)
```bash
flutter clean
flutter pub get
flutter run
```

### Impossible de se connecter à Firestore
→ Vérifie que Firebase est configuré et que tu as internet.

---

## 📞 Besoin d'aide?

- Demande les clés Firebase à [creator name]
- Vérifie le fichier CLAUDE.md pour les notes de développement

Bon développement! 🎉
