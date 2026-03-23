# Où Trouver et Générer google-services.json

Guide pour **télécharger** le fichier depuis Firebase (étape par étape avec captures).

---

## 🔍 RÉSUMÉ RAPIDE

1. Va sur [Firebase Console](https://console.firebase.google.com/)
2. Crée un projet (ou utilise un existant)
3. Ajoute une app Android
4. **Télécharge** le fichier `google-services.json`
5. Place-le dans `android/app/`

---

## 📍 ÉTAPE 1: Firebase Console

### 1.1 Ouvre la console Firebase
- Clique sur ce lien: https://console.firebase.google.com/
- Connecte-toi avec ton compte Google

### 1.2 Écran d'accueil
Tu dois voir:
- Tes projets existants (s'il y en a)
- Bouton **"Créer un projet"** ou **"Ajouter un projet"**

---

## ✨ ÉTAPE 2: Créer un Projet Firebase (si tu n'en as pas)

### 2.1 Clique sur "Créer un projet"
1. Une fenêtre s'ouvre
2. Remplis le nom: `NeighborDrop` (ou autre)
3. Accepte les conditions
4. **Clique "Créer"** → Attends 30 secondes

### 2.2 Projet créé ✅
Tu es maintenant dans ton projet Firebase.

---

## 🤖 ÉTAPE 3: Ajouter une App Android à Firebase

### 3.1 Depuis le Dashboard Firebase
Tu dois voir l'écran d'accueil du projet avec:
- Le nom de ton projet en haut
- Plusieurs options: "Commencer"

### 3.2 Cherche l'option "Ajouter une app"
Il y a plusieurs façons:

**Option A: Bouton central**
- Au milieu de l'écran: tu vois des icônes (iOS, Android, Web)
- **Clique sur l'icône Android** (le robot vert)

**Option B: Menu de gauche**
- En haut à gauche: clique sur ⚙️ (Paramètres)
- Puis onglet "Vos apps"
- Clique sur **"Ajouter une app"**

### 3.3 Remplis les informations Android
Une fenêtre demande:

**"Nom du package Android"**
```
com.example.studymate
```
(C'est le nom de l'app Android)

**"Alias de l'app (optionnel)"**
```
NeighborDrop
```
(Juste un surnom)

**"Empreinte SHA-1 (optionnel)"**
- Laisse vide pour maintenant

### 3.4 Clique sur "Enregistrer l'app"
L'app ajoute te demande de **"Télécharger le fichier de configuration"**

---

## 📥 ÉTAPE 4: TÉLÉCHARGER google-services.json

### 4.1 Tu vois cet écran
À gauche: "Télécharger le fichier de configuration"
- **Un gros bouton bleu:** "Télécharger google-services.json"

### 4.2 Clique sur le bouton bleu
Le fichier s'enregistre dans tes **Téléchargements**

### 4.3 Vérifie que le fichier est là
1. Ouvre tes Téléchargements: cherche `google-services.json`
2. Le fichier doit faire environ 1-2 KB
3. Ce n'est pas un dossier, juste un fichier `google-services.json`

---

## 🚚 ÉTAPE 5: Placer le fichier au bon endroit

### Localisation finale
```
Mobil_Design_Class_2026/
├── NeighborDrop/
│   ├── android/
│   │   ├── app/
│   │   │   ├── google-services.json  ← LE FICHIER VA ICI!
│   │   │   ├── build.gradle
│   │   │   └── src/
│   │   ├── build.gradle
│   │   └── gradle.properties
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
```

### Copier le fichier

**Avec l'Explorateur Windows:**
1. Ouvre `C:\Users\[TonNom]\Downloads`
2. Cherche `google-services.json`
3. Fais **Copier** (Ctrl+C)
4. Va à `Mobil_Design_Class_2026\NeighborDrop\android\app\`
5. Fais **Coller** (Ctrl+V) ✅

**Ou directement dans VS Code:**
1. Ouvre VS Code
2. À gauche, va dans `android/app/`
3. Fais **clic-droit** → Ouvre le dossier dans l'Explorateur
4. Copie-colle le fichier ici

---

## ✅ VÉRIFIER QUE C'EST BON

### Check 1: Le fichier existe
- Dans VS Code: `android/app/google-services.json` visible ✅
- Dans l'Explorateur: le fichier est là ✅

### Check 2: Firebase Console
- Va dans Firebase → Vos apps
- Tu vois "Studymate" (ou le nom de l'app) avec le logo Android ✅

### Check 3: Lancer l'app
```bash
cd NeighborDrop
flutter clean
flutter pub get
flutter run
```

---

## 📱 Si tu as plein de fichiers google-services.json

### Attention!
- **Android:** `google-services.json`
- **iOS:** `GoogleService-Info.plist`
- **Web:** Va dans Firebase Console → Code

Ne les confonds pas! Pour ce projet Flutter, on utilise juste:
- ✅ `google-services.json` (pour Android)

---

## 🎯 Pas à pas visuel - Version courte

1. **Firebase Console** → Crée projet
2. **Ajouter une app** → Clique icône Android
3. **Remplis:** `com.example.studymate`
4. **Télécharge** le fichier verte bouton
5. **Place dans:** `android/app/google-services.json`
6. **Teste:** `flutter run`

C'est tout! 🚀

---

## 🆘 Si ça ne marche pas

### "Je ne vois pas l'option ajouter une app"
→ Va dans ⚙️ (Paramètres) → Section "Vos apps" → Clique "Ajouter une app"

### "Le fichier ne s'est pas téléchargé"
→ Vérifie dans tes Téléchargements. Cherche `google-services.json`

### "Je ne sais pas où mettre le fichier"
→ Ouvre l'Explorateur et va à: `Mobil_Design_Class_2026\NeighborDrop\android\app\`

### "Le bouton de téléchargement n'apparaît pas"
→ Vérifie que tu as cliqué sur "Enregistrer l'app" d'abord
