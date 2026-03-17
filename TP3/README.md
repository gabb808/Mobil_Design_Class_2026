# StudyMate

Application mobile Flutter permettant aux etudiants de trouver des partenaires d'etude.

## Contexte

Projet realise pour l'association etudiante **Campus Connect** (~2000 etudiants). Les etudiants veulent reviser a plusieurs mais ne savent pas qui est disponible ni qui maitrise quelle matiere. StudyMate centralise la recherche de partenaires d'etude.

## Fonctionnalites

- **Liste des partenaires** : parcourir les profils d'etudiants disponibles, filtrer par matiere, rechercher par nom
- **Profil detaille** : consulter la bio, les matieres maitrisees, les disponibilites et les avis d'un partenaire
- **Demande de session** : envoyer une demande en choisissant la matiere, le creneau, le lieu (bibliotheque/cafe/en ligne) et un message personnalise
- **Favoris** : sauvegarder ses partenaires preferes (persistance locale)
- **Gestion des etats** : loading, erreur, liste vide, mode offline (cache)

## Stack technique

| Technologie | Usage |
|------------|-------|
| Flutter | Framework mobile cross-platform |
| GetX | State management, routing, dependency injection |
| SharedPreferences | Stockage local (favoris) |
| Google Fonts | Typographie (Inter) |
| flutter_rating_bar | Affichage des notes/etoiles |

## Structure du projet

```
lib/
  core/
    models/           -> StudyPartner, SessionRequest, Review
    repositories/     -> StudymateRepository (donnees mockees)
  screens/
    partners_list/    -> Ecran 1 : liste des partenaires
    partner_detail/   -> Ecran 2 : profil detaille
    session_request/  -> Ecran 3 : formulaire de demande
    widgets/          -> Composants reutilisables
  shared/theme/       -> Couleurs, dimensions, typographie
  main.dart
```

## Lancer le projet

```bash
cd studymate
flutter pub get
flutter run
```

## Generer l'APK

```bash
flutter build apk --release
```

L'APK se trouve dans `build/app/outputs/flutter-apk/app-release.apk`.

## Documents du projet

- [BRIEF_PO.md](./Brief%20PO.md) - Analyse du brief client
- [ARCHITECTURE.md](./architechture.md) - Choix techniques et structure
- [DESIGN_SYSTEM.md](./Design_system.md) - Couleurs, typographie, composants
- [CLAUDE.md](./CLAUDE.md) - Instructions IA

## Equipe

Projet realise dans le cadre du cours de Mobile Design - ESILV A4 S2.
