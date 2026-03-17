# BRIEF PO -- NeighborDrop

## Section 1 : Concept

**1. C'est quoi ?**

> Une app mobile de don et troc entre voisins. Les utilisateurs postent des articles qu'ils donnent/troquent et peuvent browsez les articles disponibles dans leur quartier. Ils peuvent envoyer des propositions et discuter directement avec d'autres voisins.

**2. C'est pour qui ?**

> Les habitants d'un quartier (tous ages) qui veulent donner/troquer des articles avec leurs voisins plutôt que de les jeter.

**3. Ca resout quel probleme ?**

> Réduire les déchets en facilitant les dons et échanges entre voisins. Créer une communauté locale. Donner une seconde vie aux objets.

**Client :** Association locale "Quartier Solidaire"


## Section 2 : Ecrans

### Ecran 1 : Accueil - Liste des articles disponibles

**C'est quoi cet ecran ?**

> Ecran principal affichant tous les articles disponibles au don/troc dans le quartier sous forme de cards.

**C'est le premier ecran que l'utilisateur voit ?**

> Oui

**Quels COMPOSANTS sur cet ecran ?**

> Header "NeighborDrop" + icone recherche
> Filtre par quartier / code postal
> Filtres par categorie horizontaux (Tous / Vetements / Livres / Electromenager / Jouets / Autres)
> Liste de cards articles (photo, nom, categorie, taille/poids, nom du voisin)
> Bouton "+" (ajouter un article) en bas a droite
> Bottom navigation (Accueil / Mes articles / Profil)

**Wireframe :**
```
+-------------------------+
| NeighborDrop       [Q]  |
+-------------------------+
| [Mon quartier: 75012 v] |
+-------------------------+
|[Tous][Vete][Livres]...  |
+-------------------------+
| +---------------------+ |
| | [Photo VTT]         | |
| | VTT Orange          | |
| | Sports / 25kg       | |
| | Jean (75012)        | |
| +---------------------+ |
+-------------------------+
| +---------------------+ |
| | [Photo Table]       | |
| | Table basse         | |
| | Meuble / 5kg        | |
| | Marie (75012)       | |
| +---------------------+ |
+-------------------------+
| [Accueil] [Mes articles] [Profil] |
+-------------------------+
|              [+]         |
+-------------------------+
```

**Les 6 etats :**

| Etat | Applicable ? | Description UI / Justification |
|------|-------------|-------------------------------|
| `Loading` | Oui | Spinner + "Chargement des articles..." |
| `Success` | Oui | Liste des articles visible |
| `Empty` | Oui | Message "Aucun article pour l'instant" + suggestion d'elargir quartier |
| `Error` | Oui | Toast "Erreur lors du chargement" |
| `NoConnection` | Oui | Affichage en cache si disponible |
| `Filtered` | Oui | Liste filtree par categorie avec chip actif |


### Ecran 2 : Detaille d'un article

**C'est quoi cet ecran ?**

> Page complete d'un article avec photo grande, description, categorie, taille/poids, profil du donneur et bouton pour envoyer une proposition.

**C'est le premier ecran que l'utilisateur voit ?**

> Non (tap sur card de l'ecran 1)

**Quels COMPOSANTS sur cet ecran ?**

> Photo de l'article (grande, scrollable si plusieurs photos)
> Nom de l'article
> Categorie + taille/poids + etat (Neuf / Bon etat / Occasion)
> Description courte de l'article
> Carte du donneur (photo, prenom, quartier, rating)
> Bouton "Proposer un echange" (primary, sticky bottom)
> Bouton "Contacter le voisin" (secondary)

**Wireframe :**
```
+-------------------------+
| <  Article          [+] |
+-------------------------+
|     [Photo VTT]         |
|     [Photo 2]           |
+-------------------------+
|      VTT Orange         |
| [Sports] - 25kg - Neuf  |
+-------------------------+
| "VTT enfant en bon etat,|
|  peu utilise. Idee pour |
|  faire du sport!"       |
+-------------------------+
| Donneur :               |
| +---------------------+ |
| |[Photo] Jean         | |
| | Quartier: 75012     | |
| | Membre depuis 2 ans | |
| +---------------------+ |
+-------------------------+
| [Proposer un echange]   |
| [Contacter le voisin]   |
+-------------------------+
```

**Les 6 etats :**

| Etat | Applicable ? | Description UI / Justification |
|------|-------------|-------------------------------|
| `Loading` | Oui | Skeleton loaders |
| `Success` | Oui | Tous les details charges |
| `Empty` | Non | Un article a toujours un nom et une categorie |
| `Error` | Oui | Message "Article non trouve" + retour |
| `NoConnection` | Oui | Cache si disponible |
| `ArticleDeleted` | Oui | "Cet article n'existe plus" |


### Ecran 3 : Poster un article

**C'est quoi cet ecran ?**

> Formulaire pour poster un nouvel article au don. L'utilisateur remplit tous les details de l'article.

**C'est le premier ecran que l'utilisateur voit ?**

> Non (tap sur bouton "+" de l'ecran 1)

**Quels COMPOSANTS sur cet ecran ?**

> Champ "Nom de l'article" (texte)
> Dropdown "Categorie" (Vetements / Livres / Electromenager / Jouets / Autres)
> Champ "Taille/Poids" (texte)
> Dropdown "Etat" (Neuf / Bon etat / Occasion)
> Textarea "Description" (details sur l'article)
> Button "Ajouter une photo" (upload image)
> Champ "Code postal / Quartier" (pre-rempli du profil)
> Bouton "Poster" (primary)

**Wireframe :**
```
+-------------------------+
| <  Poster un article    |
+-------------------------+
| Nom :                   |
| [VTT Orange          ]  |
+-------------------------+
| Categorie :             |
| [v Sports            ]  |
+-------------------------+
| Taille/Poids :          |
| [25kg                ]  |
+-------------------------+
| Etat :                  |
| [v Neuf               ]  |
+-------------------------+
| Description :           |
| +---------------------+ |
| | VTT enfant peu util | |
| |                     | |
| +---------------------+ |
+-------------------------+
| [Ajouter une photo]     |
+-------------------------+
| Code postal:            |
| [75012               ]  |
+-------------------------+
| [Poster]                |
+-------------------------+
```

**Les 6 etats :**

| Etat | Applicable ? | Description UI / Justification |
|------|-------------|-------------------------------|
| `Loading` | Oui | Spinner sur le bouton "Poster" |
| `Success` | Oui | Snackbar "Article poste !" + retour ecran 1 |
| `ValidationError` | Oui | Erreurs sous champs requis |
| `Error` | Oui | Toast "Erreur lors de la publication" |
| `NoConnection` | Oui | Message "Sauvegarde en local, sera publie online" |
| `ImageUploadError` | Oui | Toast "Erreur upload image" |


---

## Section 3 : Filtres et Actions

| Ecran | Action / Filtre | Type | Detail |
|-------|----------------|------|--------|
| Ecran 1 | Filtrer par categorie | Tap sur chip | Tous / Vetements / Livres / Electromenager / Jouets / Autres |
| Ecran 1 | Changer quartier | Tap sur dropdown quartier | Selectionner son code postal |
| Ecran 1 | Voir article | Tap sur card | Navigation vers Ecran 2 |
| Ecran 1 | Poster article | Tap sur bouton "+" | Navigation vers Ecran 3 |
| Ecran 1 | Rafraichir | Swipe down | Pull-to-refresh |
| Ecran 2 | Proposer echange | Tap sur bouton | Bottom sheet proposer/echanger |
| Ecran 2 | Contacter voisin | Tap sur bouton | Navigation vers Messages (Ecran 5) |
| Ecran 2 | Retour | Tap sur fleche back | Retour Ecran 1 |
| Ecran 3 | Selectionner categorie | Tap dropdown | Liste categories |
| Ecran 3 | Choisir etat | Tap dropdown | Neuf / Bon etat / Occasion |
| Ecran 3 | Uploader photo | Tap bouton | Ouvre galerie |
| Ecran 3 | Poster | Tap bouton | Validation + envoi |
| Ecran 4 | Editer profil | Tap sur icone edit | Modification donnees utilisateur |
| Ecran 4 | Voir mes articles | Tap sur tab | Liste des articles postes |
| Ecran 5 | Envoyer message | Saisie + envoi | Message au voisin |


---

## Section 4 : Donnees

### Source des donnees

- [ ] API publique
- [x] Base de donnees en ligne (Firebase Firestore)
- [x] Stockage local (SharedPreferences + cache local)

### Mode offline

- [ ] Tout fonctionne
- [x] Mode degrade (affichage cache, actions sauvegardees localement)
- [ ] Rien ne fonctionne

### Models

- Model 1 : **Article** (article a donner/troquer)
- Model 2 : **User** (profil du voisin)
- Model 3 : **Proposition** (proposition d'echange)


---

## Section 5 : Hors scope MVP

- Chat en temps reel
- Systeme de rating/avis entre voisins
- Geolocalisation en temps reel
- Notifications push
- Partage social (inviter amis)
- Authentification Firebase (MVP = donnees mockees)
- Paiement / systeme de points
- Historique des echanges


---

## Section 6 : Criteres de succes MVP

1. ✓ L'utilisateur voit la liste des articles disponibles dans son quartier
2. ✓ L'utilisateur peut filtrer les articles par categorie
3. ✓ L'utilisateur peut voir le detail complet d'un article
4. ✓ L'utilisateur peut poster un nouvel article avec photo, nom, categorie, taille/poids
5. ✓ L'utilisateur peut proposer un echange sur un article
6. ✓ L'utilisateur peut voir son profil et ses articles postes
7. ✓ L'app gere les etats (loading, error, empty, success)
