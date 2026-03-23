# NeighborDrop

Application mobile Flutter de don et troc entre voisins.

## Contexte

Projet de refonte. L'application (initialement pensée autour d'un concept étudiant) s'appelle techniquement studymate mais porte le concept **NeighborDrop**. Elle permet aux habitants d'un quartier d'afficher, de donner et d'échanger des objets (articles) avec leurs voisins pour donner une seconde vie aux objets et réduire les déchets.

## Fonctionnalités (Récentes)

- **Liste des articles** : Parcourir les articles disponibles, voir les catégories, et leur état (Neuf, Bon état, etc).
- **Détail de l'article** : Voir la description de l'objet, consulter le profil du donneur et les détails.
- **Messagerie** : Envoyer des messages au propriétaire, proposer des échanges (troc).
- **Profil Utilisateur** : Gérer ses propres articles (Mes annonces).
- **Nouveau : Favoris** : Sauvegarder ses articles préférés avec mise en évidence sur l'interface (icône cœur).
- **Propreté du code** : Zéro avertissements d'analyse (0 problems), nettoyage des méthodes obsolètes (remplacement de withOpacity par withValues).

## Stack technique

| Technologie | Usage |
|------------|-------|
| Flutter | Framework mobile cross-platform |
| GetX | State Management (Obx, Controllers), routing, dependency injection |
| Google Fonts | Typographie |
| Dart | Contraintes Dart 3+ strictes sans warnings |

## Structure du projet

`
lib/
  core/
    models/           -> Article, User, Message, Conversation
    repositories/     -> StudymateRepository (données mockées et favoris locaux)
  screens/
    articles_list/    -> Accueil : liste des articles
    article_detail/   -> Détail d'un article
    messages/         -> Messagerie et propositions d'échange
    user_profile/     -> Profil et mes annonces
  shared/
    theme/            -> Couleurs (AppColors), dimensions, typographie
  main.dart           -> Point d'entrée et routes
`

## Lancer le projet

`ash
cd studymate
flutter pub get
flutter run
`

## Documents du projet

- [BRIEF_PO.md](./Brief%20PO.md) - Analyse du brief client
- [ARCHITECTURE.md](./architechture.md) - Choix techniques et structure
- [DESIGN_SYSTEM.md](./Design_system.md) - Couleurs, typographie, composants
- [CLAUDE.md](./CLAUDE.md) - Instructions IA
