# ARCHITECTURE -- StudyMate

> Le Brief PO definit QUOI construire. Ce document definit COMMENT.

---

## Section 1 : Structure du projet

```
lib/
├── core/
│   ├── models/
│   │   ├── study_partner.dart
│   │   ├── session_request.dart
│   │   └── review.dart
│   │
│   ├── repositories/
│   │   └── studymate_repository.dart
│   │
│   └── services/
│       └── studymate_service.dart
│
├── screens/
│   ├── partners_list/
│   │   ├── partners_list_screen.dart
│   │   └── partners_list_controller.dart
│   │
│   ├── partner_detail/
│   │   ├── partner_detail_screen.dart
│   │   └── partner_detail_controller.dart
│   │
│   ├── session_request/
│   │   ├── session_request_screen.dart
│   │   └── session_request_controller.dart
│   │
│   └── widgets/
│       ├── partner_card.dart
│       ├── review_tile.dart
│       ├── subject_chip.dart
│       └── availability_slot.dart
│
├── shared/
│   └── theme/
│       ├── app_colors.dart
│       ├── app_dimens.dart
│       └── app_text_styles.dart
│
└── main.dart
```

**Noms choisis :**

| Placeholder | Valeur | Justification |
|-------------|--------|---------------|
| `[projet]` | `studymate` | Nom de l'app |
| `[model1]` | `study_partner` | Profil d'un etudiant partenaire |
| `[model2]` | `session_request` | Demande de session d'etude |
| `[model3]` | `review` | Avis laisse par un etudiant |
| `[ecran1]` | `partners_list` | Ecran principal listant les partenaires |
| `[ecran2]` | `partner_detail` | Ecran de profil detaille |
| `[ecran3]` | `session_request` | Formulaire de demande de session |
| `[widget1]` | `partner_card` | Card reutilisable pour chaque partenaire |
| `[widget2]` | `review_tile` | Composant avis (ecran 2) |
| `[widget3]` | `subject_chip` | Chip matiere reutilisable (ecrans 1 + 2) |
| `[widget4]` | `availability_slot` | Creneau horaire affiche (ecran 2 + 3) |


---

## Section 2 : Mes donnees

### Model 1 : StudyPartner

| Champ | Type | Exemple de valeur | Affiche sur quel ecran ? |
|-------|------|-------------------|--------------------------|
| id | String | "partner_001" | -- |
| firstName | String | "Marie" | Ecrans 1, 2, 3 |
| lastName | String | "Dupont" | Ecran 2 |
| photoUrl | String | "https://..." | Ecrans 1, 2 |
| bio | String | "Etudiante en L3 Maths..." | Ecran 2 |
| mainSubject | String | "Mathematiques" | Ecran 1 |
| subjects | List&lt;String&gt; | ["Maths", "Stats", "Algo"] | Ecran 2 |
| averageRating | double | 4.5 | Ecrans 1, 2 |
| reviewCount | int | 12 | Ecrans 1, 2 |
| availabilities | List&lt;Availability&gt; | [{day: "Lundi", start: "14h", end: "16h"}] | Ecrans 2, 3 |
| nextAvailability | String | "Lun 14h" | Ecran 1 |
| isFavorite | bool | false | Ecrans 1, 2 (local) |

### Model 2 : SessionRequest

| Champ | Type | Exemple de valeur | Affiche sur quel ecran ? |
|-------|------|-------------------|--------------------------|
| id | String | "req_001" | -- |
| partnerId | String | "partner_001" | Ecran 3 (logique) |
| partnerName | String | "Marie" | Ecran 3 |
| subject | String | "Mathematiques" | Ecran 3 |
| timeSlot | String | "Lun 14h-16h" | Ecran 3 |
| location | String | "bibliotheque" / "cafe" / "en_ligne" | Ecran 3 |
| message | String | "Salut ! J'aimerais revoir..." | Ecran 3 |
| status | String | "pending" / "accepted" / "declined" | -- |
| createdAt | DateTime | 2026-03-13 | -- |

### Model 3 : Review

| Champ | Type | Exemple de valeur | Affiche sur quel ecran ? |
|-------|------|-------------------|--------------------------|
| id | String | "rev_001" | -- |
| authorName | String | "Thomas" | Ecran 2 |
| rating | double | 5.0 | Ecran 2 |
| comment | String | "Super claire !" | Ecran 2 |
| createdAt | DateTime | 2026-03-11 | Ecran 2 |


---

## Section 3 : Qui fait quoi ?

### Repository : StudymateRepository

**Responsabilites :**
- Recuperer la liste des partenaires disponibles (avec filtres par matiere)
- Recuperer le profil detaille d'un partenaire
- Recuperer les avis d'un partenaire
- Envoyer une demande de session
- Gerer les favoris (ajout/suppression, stockage local)

**Donnees utilisees :**
- Models : StudyPartner, SessionRequest, Review
- Source : Donnees mockees en local (JSON) simulant une API / Firebase
- Cache local : SharedPreferences (favoris)

### Service : StudymateService

**Responsabilites :**
- Fournir les donnees mockees (simuler des appels API)
- Gerer le cache local
- Valider les donnees du formulaire de session

### Controllers (GetX)

**PartnersListController :**
- Etat : loading, success, empty, error, noConnection
- Variables : partnersList, filteredList, selectedSubject, searchQuery
- Methodes : fetchPartners(), filterBySubject(subject), search(query), toggleFavorite(id), refresh()

**PartnerDetailController :**
- Etat : loading, success, error, noConnection
- Variables : partner, reviews, isFavorite, isLoading
- Methodes : loadPartnerDetail(id), loadReviews(partnerId), toggleFavorite()

**SessionRequestController :**
- Etat : idle, sending, success, error, validationError
- Variables : selectedSubject, selectedSlot, selectedLocation, message, isFormValid
- Methodes : selectSubject(s), selectSlot(s), selectLocation(l), setMessage(m), sendRequest(), validate()


| Methode | Ce qu'elle fait | Quel model ? |
|---------|-----------------|--------------|
| fetchPartners(filters) | Recupere la liste des partenaires filtres | StudyPartner |
| getPartnerDetail(id) | Recupere profil complet d'un partenaire | StudyPartner |
| getReviews(partnerId) | Recupere les avis d'un partenaire | Review |
| sendSessionRequest(request) | Envoie une demande de session | SessionRequest |
| addToFavorites(partnerId) | Ajoute un partenaire aux favoris | StudyPartner (SharedPreferences) |
| removeFromFavorites(partnerId) | Retire un partenaire des favoris | StudyPartner (SharedPreferences) |
| getFavorites() | Recupere la liste des IDs en favoris | List&lt;String&gt; |

### Service

| Methode | Ce qu'elle fait | Utilisee sur quel ecran ? |
|---------|-----------------|---------------------------|
| getMockPartners() | Retourne les donnees mockees de partenaires | Ecran 1 |
| getMockReviews(partnerId) | Retourne les avis mockes | Ecran 2 |
| validateSessionRequest(req) | Valide les champs du formulaire | Ecran 3 |
| cachePartners(list) | Sauvegarde la liste en cache local | Ecran 1 |
| getCachedPartners() | Recupere le cache si offline | Ecran 1 |

### Controllers

| Ecran | Controller |
|-------|-----------|
| Ecran 1 : Partners List | PartnersListController |
| Ecran 2 : Partner Detail | PartnerDetailController |
| Ecran 3 : Session Request | SessionRequestController |

### Scenarios de flux

**Ecran 1 -- Partners List :**

> Source : donnees mockees -> Repository : fetchPartners() -> Controller : etat = loading|success|empty|error -> Screen : affiche liste ou spinner

**Ecran 2 -- Partner Detail :**

> Source : donnees mockees (cache possible) -> Repository : getPartnerDetail(id) + getReviews(id) -> Controller : etat = loading|success|error -> Screen : affiche profil complet

**Ecran 3 -- Session Request :**

> Source : formulaire utilisateur -> Controller : validate() -> Repository : sendSessionRequest() -> Controller : etat = sending|success|error|validationError -> Screen : feedback utilisateur


---

## Section 4 : D'ou viennent mes donnees ?

**1. Source de donnees :**

- [ ] Hive (stockage local)
- [ ] API publique
- [ ] Supabase / Firebase
- [x] Autre : donnees mockees en local (JSON hardcode dans le repository)

**2. Donnees mockees :**

> Les donnees sont definies directement dans `studymate_repository.dart` sous forme de listes d'objets StudyPartner, Review, etc. Cela simule une API REST.

**3. Exemple de donnees JSON :**

```json
{
  "partners": [
    {
      "id": "partner_001",
      "firstName": "Marie",
      "lastName": "Dupont",
      "photoUrl": "https://i.pravatar.cc/150?img=1",
      "bio": "Etudiante en L3 Maths, j'adore expliquer les concepts complexes",
      "mainSubject": "Mathematiques",
      "subjects": ["Maths", "Statistiques", "Algorithmique"],
      "averageRating": 4.5,
      "reviewCount": 12,
      "nextAvailability": "Lun 14h",
      "availabilities": [
        {"day": "Lundi", "start": "14:00", "end": "16:00"},
        {"day": "Mercredi", "start": "10:00", "end": "12:00"}
      ]
    }
  ]
}
```

**4. Stockage local :**

| Nom | Stocke quoi ? |
|-----|---------------|
| favorites | List&lt;String&gt; (IDs des partenaires en favoris) |
| cached_partners | String (JSON de la derniere liste chargee) |

**5. Que se passe-t-il quand l'utilisateur ferme et rouvre l'app ?**

- [ ] Tout persiste (donnees locales)
- [x] Donnees rechargees (donnees mockees rechargees a chaque lancement)
- [ ] Cache local + sync

Les favoris persistent via SharedPreferences. Les donnees de la liste sont rechargees depuis le mock.


---

## Section 5 : Packages

### Toujours necessaires :

- [x] `get` (state management + routing + dependency injection)
- [x] `json_annotation` (serialisation JSON)

### Pour ce projet :

- [x] `shared_preferences` (stockage favoris)
- [x] `flutter_rating_bar` (affichage etoiles)
- [x] `google_fonts` (typographie Poppins ou Inter)
- [x] `intl` (dates formatees)
- [x] `cached_network_image` (images de profil avec cache)
