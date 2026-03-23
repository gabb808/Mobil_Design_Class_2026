# CLAUDE.md -- NeighborDrop

## Projet
NeighborDrop est une application mobile Flutter de don et troc entre voisins. Les utilisateurs peuvent poster des articles qu'ils donnent, parcourir les articles disponibles dans leur quartier, envoyer des propositions d'échange, et communiquer avec d'autres voisins.

## Stack technique
- **Framework** : Flutter (Dart)
- **State management** : GetX
- **Donnees** : Donnees mockees en local (MVP)
- **Stockage local** : SharedPreferences (cache)
- **Architecture** : Repository Pattern (Controllers -> Repository -> Data)

## Structure du projet
```
lib/
  core/models/         -> Article, AppUser, Proposition
  core/repositories/   -> NeighbordropRepository (donnees mockees)
  screens/
    articles_list/        -> ArticlesListController, ArticlesListScreen
    article_detail/       -> ArticleDetailController, ArticleDetailScreen
    post_article/         -> PostArticleController, PostArticleScreen
    user_profile/         -> UserProfileController, UserProfileScreen
    messages/             -> MessagesController, MessagesScreen
  shared/theme/        -> app_colors, app_dimens, app_text_styles
  main.dart
```

## Les 5 Screens MVP

### 1. Articles List (Accueil)
- Affiche tous les articles disponibles au don/troc
- Filtrable par catégorie (Vêtements, Livres, Électroménager, etc.)
- Filtrable par code postal/quartier
- Card article: photo, nom, catégorie, poids, donateur
- Bouton "+" pour poster un article

### 2. Article Detail
- Vue complète d'un article
- Description, condition (Neuf/Bon état/Occasion)
- Profil du donateur avec rating
- Bouton "Proposer un échange" (modal avec message)
- Bouton "Contacter le voisin"

### 3. Post Article
- Formulaire pour poster un nouvel article
- Champs: Nom, Catégorie, Taille/Poids, Description, État
- Bouton "Ajouter une photo" (non implémenté pour MVP)
- Code postal pré-rempli du profil utilisateur

### 4. User Profile
- Photo de profil
- Nom, quartier, bio
- Stats: articles postés, échanges complétés, rating
- Boutons: "Éditer profil", "Mes articles" (non implémentés pour MVP)

### 5. Messages
- Écran basique de chat avec un voisin
- Input message + envoi
- Affichage des messages en bubbles

## Design System
- **Couleurs** : Primary #2E7D32 (vert), Secondary #FF9800 (orange), Background #FAFAFA
- **Typo** : Inter (Google Fonts), Headings bold, Body regular
- **Spacing** : XS(4px), S(8px), M(16px), L(24px)
- **Bordures** : Cards 12px, Boutons 8px, Chips 20px

## Conventions de code
- Nommage des fichiers : snake_case
- Nommage des classes : PascalCase
- Nommage des variables : camelCase
- Un controller par screen (GetX)
- Les données mockées sont dans le repository, pas dans les controllers
- Tous les widgets sont dans les screens (pas de dossier widgets/ pour le MVP)

## Routes disponibles
- `/` : ArticlesListScreen (accueil avec liste d'articles)
- `/article-detail` : ArticleDetailScreen (détail d'un article)
- `/post-article` : PostArticleScreen (formulaire de poster un article)
- `/profile` : UserProfileScreen (mon profil)
- `/messages` : MessagesScreen (chat avec un voisin)

## Données mockées
5 articles d'exemple avec:
- ID unique
- Nom, catégorie, taille/poids, description
- Condition (Neuf/Bon état/Occasion)
- Photo URL (images Unsplash)
- Donateur (profil limité)

3 utilisateurs d'exemple (Jean, Marie, Thomas) avec:
- Profil complet
- Rating et statistiques
- Articles postés et échanges complétés

## Commandes utiles
```bash
flutter pub get          # installer les dépendances
flutter run              # lancer l'app
flutter format lib/      # formater le code
flutter build apk        # générer l'APK
```

## Prochaines étapes (post-MVP)
- [ ] Intégration Firebase Firestore
- [ ] Authentification Firebase
- [ ] Upload d'images (Firebase Storage)
- [ ] Chat en temps réel
- [ ] Système de rating/avis
- [ ] Notifications push
- [ ] Géolocalisation
- [ ] Historique des échanges
