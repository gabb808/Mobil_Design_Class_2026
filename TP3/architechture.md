# ARCHITECTURE -- NeighborDrop (ex-StudyMate)

> Le Brief PO définit QUOI construire. Ce document définit COMMENT.

---

## Section 1 : Structure du projet

`
lib/
├── core/
│   ├── models/
│   │   ├── article.dart
│   │   ├── user.dart
│   │   ├── message.dart
│   │   └── conversation.dart
│   │
│   ├── repositories/
│   │   └── studymate_repository.dart
│
├── screens/
│   ├── articles_list/
│   │   ├── articles_list_screen.dart
│   │   └── articles_list_controller.dart
│   │
│   ├── article_detail/
│   │   ├── article_detail_screen.dart
│   │   └── article_detail_controller.dart
│   │
│   ├── messages/
│   │   ├── messages_screen.dart
│   │   └── messages_controller.dart
│   │
│   └── user_profile/
│       ├── user_profile_screen.dart
│       ├── my_articles_screen.dart
│       └── my_articles_controller.dart
│
├── shared/
│   └── theme/
│       ├── app_colors.dart
│       ├── app_dimens.dart
│       └── app_text_styles.dart
│
└── main.dart
`

**Noms choisis :**

| Placeholder | Valeur | Justification |
|-------------|--------|---------------|
| [projet] | studymate/NeighborDrop | Nom de l'app technique / produit |
| [model1] | rticle | Objet à donner/échanger |
| [model2] | user | Utilisateur de la plateforme |
| [model3] | message/conversation | Echanges entre utilisateurs |
| [ecran1] | rticles_list | Ecran principal listant les objets |
| [ecran2] | rticle_detail | Ecran de profil/détail de l'objet |
| [ecran3] | messages | Ecran de messagerie/troc |
| [ecran4] | user_profile | Profil utilisateur et Mes Annonces |


---

## Section 2 : Mes données

### Model 1 : Article

| Champ | Type | Exemple de valeur | Affiché sur quel écran ? |
|-------|------|-------------------|--------------------------|
| id | String | "art_001" | -- |
| name | String | "Chaise en bois" | Ecrans 1, 2 |
| description | String | "Bon état" | Ecran 2 |
| photoUrl | String | "https://..." | Ecrans 1, 2 |
| condition | String | "Bon état" | Ecrans 1, 2 |
| category | String | "Mobilier" | Ecrans 1, 2 |
| ownerId | String | "user_001" | Ecran 2 |
| isFavorite | bool | false | Ecrans 1, 2 (local) |

### Model 2 : Message/Conversation

| Champ | Type | Exemple de valeur | Affiché sur quel écran ? |
|-------|------|-------------------|--------------------------|
| id | String | "msg_001" | -- |
| content | String | "Bonjour, je suis intéressé" | Messages |
| isExchangeProposal| bool | true/false | Messages |

---

## Section 3 : Qui fait quoi ?

### Repository : StudymateRepository (Central)
**Responsabilités :**
- Récupérer la liste des articles
- Récupérer le détail d'un article et son propriétaire
- Gérer les favoris (	oggleFavorite, isFavorite) avec **GetX reactivity (RxSet)**
- Gérer la messagerie mockée

### Controllers (GetX)

**ArticlesListController :**
- Récupère les articles pour l'accueil et gère les filtres.

**ArticleDetailController :**
- Gère le détail d'un article, son propriétaire, et les actions comme l'ajout aux favoris.

**MessagesController :**
- Gère la conversation, l'envoi de messages et les propositions de troc.

**MyArticlesController :**
- Gère les articles de l'utilisateur ("Mes annonces").

---

## Section 4 : D'où viennent mes données ?

**1. Source de données :**
- [x] Autre : données mockées en local (générées dans le repository)

**2. Stockage local & Réactivité :**
| Nom | Stocke quoi ? |
|-----|---------------|
| favoris (Set) | Liste des IDs sauvés en mémoire et réactifs (Obx()) |

---

## Section 5 : Packages & Stack Technique

- [x] get (state management Rx/Obx, routing Get.to, dependency injection)
- [x] google_fonts (typographie)
- Zéro avertissements linter, code compatible Dart 3+ (Color.withValues au lieu de Color.withOpacity).
