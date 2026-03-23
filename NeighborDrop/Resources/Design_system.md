# DESIGN SYSTEM -- NeighborDrop

> Le Brief PO définit QUOI. L'Architecture définit COMMENT. Ce document définit À QUOI ÇA RESSEMBLE.

---

## Section 1 : Inspiration

**Quelle app vous inspire ?**

> LinkedIn Learning + Coursera = design épuré, studieux mais moderne, focus sur les profils et compétences

**Screenshot :**

> Design clean avec cards blanches, accents bleu foncé, photos de profil rondes, ambiance universitaire

**L'ambiance en un mot :**

- [x] Sérieuse / Corporate
- [ ] Fun / Jeune
- [x] Clean / Minimale
- [ ] Chaleureuse / Organique


---

## Section 2 : Couleurs

> Palette froide et professionnelle, inspirée du monde universitaire
> Couleurs froides (bleu foncé + blanc) comme indiqué dans le brief client

| Nom | Hex | Role |
|-----|-----|------|
| primary | #1A237E | Bouton "Demander une session", headers, actions principales (bleu foncé) |
| primaryLight | #3949AB | Hover states, chips actifs, accents (bleu moyen) |
| secondary | #FF8F00 | Étoiles de notation, badges, accents chauds (ambre) |
| background | #F5F7FA | Fond de l'app, écrans (gris très clair bleuté) |
| surface | #FFFFFF | Fond des cards (blanc pur) |
| textPrimary | #1A1A2E | Titres, texte important (quasi-noir bleuté) |
| textSecondary | #6B7280 | Sous-titres, descriptions (gris moyen) |
| success | #2E7D32 | "Demande acceptée", confirmation (vert) |
| error | #C62828 | Erreurs, validation, "Annuler" (rouge) |
| divider | #E5E7EB | Séparateurs, bordures (gris clair) |


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
| padding standard | 16px | Espace intérieur des cards, padding des écrans |
| espace entre cards | 12px | Gap vertical entre les partner cards |
| border radius cards | 12px | Coins arrondis des cards partenaires |
| border radius boutons | 8px | Coins arrondis du bouton "Demander une session" |
| border radius chips | 20px | Coins arrondis des chips matières (full rounded) |
| hauteur header | 56px | Barre du haut (app bar) |
| taille photo profil (liste) | 48x48px | Photo ronde dans les cards (écran 1) |
| taille photo profil (détail) | 120x120px | Grande photo circulaire (écran 2) |
| espacement vertical écran | 20px | Entre les sections principales d'un écran |
| hauteur partner card | ~100px | Hauteur des cards dans la liste |
| padding bottom nav | 60px | Hauteur de la bottom navigation bar |


---

## Section 5 : Composants reutilisables

### PartnerCard
- Card blanche arrondie (12px) avec ombre légère
- Photo de profil ronde à gauche (48px)
- Prénom + matière principale + note (étoiles) + prochaine disponibilité
- Icône cœur (favoris) en haut à droite

### SubjectChip
- Chip arrondi (20px) avec fond primaryLight et texte blanc
- Utilisé sur écrans 1 (filtres) et 2 (matières maîtrisées)
- État actif : fond primary, texte blanc
- État inactif : fond gris clair, texte textSecondary

### ReviewTile
- Étoiles (secondary color) + commentaire + nom auteur + date relative
- Séparateur divider en bas

### AvailabilitySlot
- Chip rectangulaire avec icône calendrier + jour + horaire
- Fond background, bordure divider, texte textPrimary

### PrimaryButton
- Fond primary, texte blanc, bold, border radius 8px
- Largeur 100% du conteneur, hauteur 48px
- Etat disabled : opacite 50%
