# DESIGN SYSTEM -- StudyMate

> Le Brief PO definit QUOI. L'Architecture definit COMMENT. Ce document definit A QUOI CA RESSEMBLE.

---

## Section 1 : Inspiration

**Quelle app vous inspire ?**

> LinkedIn Learning + Coursera = design epure, studieux mais moderne, focus sur les profils et competences

**Screenshot :**

> Design clean avec cards blanches, accents bleu fonce, photos de profil rondes, ambiance universitaire

**L'ambiance en un mot :**

- [x] Serieuse / Corporate
- [ ] Fun / Jeune
- [x] Clean / Minimale
- [ ] Chaleureuse / Organique


---

## Section 2 : Couleurs

> Palette froide et professionnelle, inspiree du monde universitaire
> Couleurs froides (bleu fonce + blanc) comme indique dans le brief client

| Nom | Hex | Role |
|-----|-----|------|
| primary | #1A237E | Bouton "Demander une session", headers, actions principales (bleu fonce) |
| primaryLight | #3949AB | Hover states, chips actifs, accents (bleu moyen) |
| secondary | #FF8F00 | Etoiles de notation, badges, accents chauds (ambre) |
| background | #F5F7FA | Fond de l'app, ecrans (gris tres clair bleuté) |
| surface | #FFFFFF | Fond des cards (blanc pur) |
| textPrimary | #1A1A2E | Titres, texte important (quasi-noir bleuté) |
| textSecondary | #6B7280 | Sous-titres, descriptions (gris moyen) |
| success | #2E7D32 | "Demande acceptee", confirmation (vert) |
| error | #C62828 | Erreurs, validation, "Annuler" (rouge) |
| divider | #E5E7EB | Separateurs, bordures (gris clair) |


---

## Section 3 : Typographie

**Police :** Inter (sans-serif, lisible, moderne et studieuse)

| Nom | Taille | Poids | Couleur |
|-----|--------|-------|---------|
| screenTitle | 24px | Bold (700) | textPrimary |
| sectionTitle | 18px | SemiBold (600) | textPrimary |
| cardTitle | 16px | SemiBold (600) | textPrimary |
| body | 14px | Regular (400) | textSecondary |
| bodySmall | 12px | Regular (400) | textSecondary |
| label | 13px | Medium (500) | textPrimary |
| buttonText | 16px | SemiBold (600) | surface (blanc) |
| chipText | 12px | Medium (500) | primary ou surface |


---

## Section 4 : Espacements

| Nom | Valeur | Utilise pour quoi ? |
|-----|--------|---------------------|
| padding standard | 16px | Espace interieur des cards, padding des ecrans |
| espace entre cards | 12px | Gap vertical entre les partner cards |
| border radius cards | 12px | Coins arrondis des cards partenaires |
| border radius boutons | 8px | Coins arrondis du bouton "Demander une session" |
| border radius chips | 20px | Coins arrondis des chips matieres (full rounded) |
| hauteur header | 56px | Barre du haut (app bar) |
| taille photo profil (liste) | 48x48px | Photo ronde dans les cards (ecran 1) |
| taille photo profil (detail) | 120x120px | Grande photo circulaire (ecran 2) |
| espacement vertical ecran | 20px | Entre les sections principales d'un ecran |
| hauteur partner card | ~100px | Hauteur des cards dans la liste |
| padding bottom nav | 60px | Hauteur de la bottom navigation bar |


---

## Section 5 : Composants reutilisables

### PartnerCard
- Card blanche arrondie (12px) avec ombre legere
- Photo de profil ronde a gauche (48px)
- Prenom + matiere principale + note (etoiles) + prochaine dispo
- Icone coeur (favoris) en haut a droite

### SubjectChip
- Chip arrondi (20px) avec fond primaryLight et texte blanc
- Utilise sur ecrans 1 (filtres) et 2 (matieres maitrisees)
- Etat actif : fond primary, texte blanc
- Etat inactif : fond gris clair, texte textSecondary

### ReviewTile
- Etoiles (secondary color) + commentaire + nom auteur + date relative
- Separateur divider en bas

### AvailabilitySlot
- Chip rectangulaire avec icone calendrier + jour + horaire
- Fond background, bordure divider, texte textPrimary

### PrimaryButton
- Fond primary, texte blanc, bold, border radius 8px
- Largeur 100% du conteneur, hauteur 48px
- Etat disabled : opacite 50%
