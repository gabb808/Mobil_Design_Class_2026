import 'package:get/get.dart';
import '../models/article.dart';
import '../models/app_user.dart';
import '../models/proposition.dart';
import '../models/conversation.dart';
import '../models/message.dart';

class NeighbordropRepository {
  // ====================================================
  // MOCK USERS  (12 utilisateurs sur 4 quartiers)
  // ====================================================
  static final List<AppUser> _mockUsers = [
    // --- 75012 Bercy / Nation ---
    AppUser(
      id: '1',
      firstName: 'Jean',
      lastName: 'Dupont',
      photoUrl: 'https://i.pravatar.cc/150?img=11',
      postalCode: '75012',
      neighborhood: 'Bercy',
      bio: 'Aime partager avec les voisins et donner une seconde vie aux objets!',
      memberRating: 4.5,
      memberSince: 2,
      articlesPosted: 8,
      exchangesCompleted: 5,
    ),
    AppUser(
      id: '2',
      firstName: 'Marie',
      lastName: 'Martin',
      photoUrl: 'https://i.pravatar.cc/150?img=5',
      postalCode: '75012',
      neighborhood: 'Bercy',
      bio: 'Passionnee de deco et de mode. Echange volontiers!',
      memberRating: 4.8,
      memberSince: 1,
      articlesPosted: 12,
      exchangesCompleted: 8,
    ),
    AppUser(
      id: '3',
      firstName: 'Thomas',
      lastName: 'Bernard',
      photoUrl: 'https://i.pravatar.cc/150?img=15',
      postalCode: '75012',
      neighborhood: 'Nation',
      bio: 'Sportif qui se debarrasse de ses anciens equipements.',
      memberRating: 4.2,
      memberSince: 3,
      articlesPosted: 6,
      exchangesCompleted: 4,
    ),
    // --- 75013 Butte-aux-Cailles / Gobelins / Olympiades ---
    AppUser(
      id: '4',
      firstName: 'Sophie',
      lastName: 'Renard',
      photoUrl: 'https://i.pravatar.cc/150?img=47',
      postalCode: '75013',
      neighborhood: 'Butte-aux-Cailles',
      bio: 'Artiste et brocantrice dans lame. Adore chiner et partager.',
      memberRating: 4.9,
      memberSince: 4,
      articlesPosted: 20,
      exchangesCompleted: 15,
    ),
    AppUser(
      id: '5',
      firstName: 'Lucas',
      lastName: 'Petit',
      photoUrl: 'https://i.pravatar.cc/150?img=33',
      postalCode: '75013',
      neighborhood: 'Olympiades',
      bio: 'Etudiant cherchant a alleger son appart. Objets en parfait etat.',
      memberRating: 4.0,
      memberSince: 1,
      articlesPosted: 5,
      exchangesCompleted: 3,
    ),
    AppUser(
      id: '6',
      firstName: 'Amina',
      lastName: 'Diallo',
      photoUrl: 'https://i.pravatar.cc/150?img=44',
      postalCode: '75013',
      neighborhood: 'Gobelins',
      bio: 'Couturiere amateur. Donne des vetements et accessoires faits main.',
      memberRating: 4.7,
      memberSince: 2,
      articlesPosted: 9,
      exchangesCompleted: 7,
    ),
    // --- 75014 Montparnasse / Alesia / Plaisance ---
    AppUser(
      id: '7',
      firstName: 'Pierre',
      lastName: 'Lefevre',
      photoUrl: 'https://i.pravatar.cc/150?img=60',
      postalCode: '75014',
      neighborhood: 'Montparnasse',
      bio: 'Architecte minimaliste. Je libere mon espace, vos gains !',
      memberRating: 4.6,
      memberSince: 5,
      articlesPosted: 14,
      exchangesCompleted: 10,
    ),
    AppUser(
      id: '8',
      firstName: 'Claire',
      lastName: 'Moreau',
      photoUrl: 'https://i.pravatar.cc/150?img=25',
      postalCode: '75014',
      neighborhood: 'Alesia',
      bio: 'Maman de 3 enfants. Donne jouets et vetements en tres bon etat.',
      memberRating: 4.9,
      memberSince: 3,
      articlesPosted: 18,
      exchangesCompleted: 14,
    ),
    AppUser(
      id: '9',
      firstName: 'Yves',
      lastName: 'Garnier',
      photoUrl: 'https://i.pravatar.cc/150?img=57',
      postalCode: '75014',
      neighborhood: 'Plaisance',
      bio: 'Ingenieur reconverti en jardinier urbain. Plantes et outils a donner.',
      memberRating: 4.3,
      memberSince: 2,
      articlesPosted: 7,
      exchangesCompleted: 5,
    ),
    // --- 75015 Grenelle / Vaugirard / Beaugrenelle ---
    AppUser(
      id: '10',
      firstName: 'Nadia',
      lastName: 'Fontaine',
      photoUrl: 'https://i.pravatar.cc/150?img=49',
      postalCode: '75015',
      neighborhood: 'Grenelle',
      bio: 'Cuisiniere passionnee. Donne electromenager et livres de recettes.',
      memberRating: 4.8,
      memberSince: 6,
      articlesPosted: 22,
      exchangesCompleted: 18,
    ),
    AppUser(
      id: '11',
      firstName: 'Kevin',
      lastName: 'Mercier',
      photoUrl: 'https://i.pravatar.cc/150?img=68',
      postalCode: '75015',
      neighborhood: 'Vaugirard',
      bio: 'Musicien. Instruments et materiel audio a trouver ici !',
      memberRating: 4.4,
      memberSince: 1,
      articlesPosted: 4,
      exchangesCompleted: 2,
    ),
    AppUser(
      id: '12',
      firstName: 'Isabelle',
      lastName: 'Chevalier',
      photoUrl: 'https://i.pravatar.cc/150?img=32',
      postalCode: '75015',
      neighborhood: 'Beaugrenelle',
      bio: 'Retraitee active. Donne livres, vaisselle et mobilier anciens.',
      memberRating: 4.7,
      memberSince: 7,
      articlesPosted: 30,
      exchangesCompleted: 25,
    ),
  ];

  // ====================================================
  // MOCK ARTICLES (26 annonces sur 4 quartiers, toutes catégories)
  // ====================================================
  static final List<Article> _mockArticles = [
    // ===== 75012 Bercy / Nation =====
    Article(
      id: 'a1',
      name: 'VTT Scott 26 pouces adulte',
      category: 'Sports',
      size: 'L',
      weight: '12kg',
      description: 'VTT adulte Scott en tres bon etat. Freins a disque, 21 vitesses. Une egratignure sur le cadre mais rien de grave. Pneus neufs.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=600',
      donorId: '1',
      donorName: 'Jean Dupont',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=11',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Article(
      id: 'a2',
      name: 'Table basse scandinave verre',
      category: 'Meuble',
      size: '120x60x40cm',
      weight: '15kg',
      description: 'Table basse en bois clair avec plateau en verre trempe. Style scandinave epure. Tres bon etat. A venir chercher sur place.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600',
      donorId: '2',
      donorName: 'Marie Martin',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=5',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Article(
      id: 'a3',
      name: 'Robe ete fleurie - taille S',
      category: 'Vetements',
      size: 'S',
      weight: '300g',
      description: 'Belle robe ete a fleurs, jamais portee. Tissu leger coton bio. Couleur bleu marine et blanc. Marque Sezane.',
      condition: 'Neuf',
      photoUrl: 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=600',
      donorId: '2',
      donorName: 'Marie Martin',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=5',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Article(
      id: 'a4',
      name: 'Lot romans policiers (8 livres)',
      category: 'Livres',
      size: 'Format poche',
      weight: '2kg',
      description: 'Collection de romans policiers francais et traduits. Auteurs: Camilleri, Nesbo, Vargas. Tous en bon etat.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=600',
      donorId: '1',
      donorName: 'Jean Dupont',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=11',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Article(
      id: 'a5',
      name: 'Trottinette electrique Xiaomi M365',
      category: 'Sports',
      size: 'Pliable',
      weight: '12kg',
      description: 'Trottinette electrique Xiaomi M365. Autonomie ~25km. Batterie en bon etat. Quelques rayures cosmétiques. Chargeur inclus.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1587201892117-e55bd7a837ea?w=600',
      donorId: '3',
      donorName: 'Thomas Bernard',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=15',
      postalCode: '75012',
      neighborhood: 'Nation',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    Article(
      id: 'a6',
      name: 'Casseroles inox - lot 12 pieces',
      category: 'Electromenager',
      size: 'Lot de 12',
      weight: '5kg',
      description: 'Casseroles et poeles en inox 18/10. Compatibles toutes plaques dont induction. Marque Cristel. Tres bon etat.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1584990347449-a76c63db79a3?w=600',
      donorId: '3',
      donorName: 'Thomas Bernard',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=15',
      postalCode: '75012',
      neighborhood: 'Nation',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),

    // ===== 75013 Butte-aux-Cailles / Olympiades / Gobelins =====
    Article(
      id: 'a7',
      name: 'Fauteuil velours vintage annees 70',
      category: 'Meuble',
      size: '70x80x90cm',
      weight: '18kg',
      description: 'Superbe fauteuil annees 70 en velours vert bouteille. Structure bois massif. Quelques accrocs sur l accoudoir - sinon parfait.',
      condition: 'Occasion',
      photoUrl: 'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=600',
      donorId: '4',
      donorName: 'Sophie Renard',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=47',
      postalCode: '75013',
      neighborhood: 'Butte-aux-Cailles',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Article(
      id: 'a8',
      name: 'Tableau huile sur toile 60x80',
      category: 'Autres',
      size: '60x80cm',
      weight: '2kg',
      description: 'Paysage breton peint a l huile par une artiste locale. Cadre bois dore inclus. Signe au dos.',
      condition: 'Neuf',
      photoUrl: 'https://images.unsplash.com/photo-1578301978018-3005759f48f7?w=600',
      donorId: '4',
      donorName: 'Sophie Renard',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=47',
      postalCode: '75013',
      neighborhood: 'Butte-aux-Cailles',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Article(
      id: 'a9',
      name: 'Machine a coudre Singer electronique',
      category: 'Electromenager',
      size: '40x20x35cm',
      weight: '6kg',
      description: 'Machine a coudre Singer electronique avec 25 points differents. Notice et accessoires inclus. Fonctionne parfaitement.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=600',
      donorId: '6',
      donorName: 'Amina Diallo',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=44',
      postalCode: '75013',
      neighborhood: 'Gobelins',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
    Article(
      id: 'a10',
      name: 'Manteau laine taille M - Maje',
      category: 'Vetements',
      size: 'M',
      weight: '800g',
      description: 'Manteau en laine melangee, coupe classique. Couleur caramel. Doublure interieure. Marque Maje. Porte une saison.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1544022613-e87ca75a784a?w=600',
      donorId: '6',
      donorName: 'Amina Diallo',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=44',
      postalCode: '75013',
      neighborhood: 'Gobelins',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Article(
      id: 'a11',
      name: 'Lego Star Wars 500 pieces - complet',
      category: 'Jouets',
      size: 'Boite 40x30cm',
      weight: '1kg',
      description: 'Set Lego Star Wars complet avec notice d origine. Toutes les pieces presentes. Minifigurines incluses.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1558060370-d644479cb6f7?w=600',
      donorId: '5',
      donorName: 'Lucas Petit',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=33',
      postalCode: '75013',
      neighborhood: 'Olympiades',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    Article(
      id: 'a12',
      name: 'Encyclopedie cuisine Larousse (3 vol.)',
      category: 'Livres',
      size: 'Grand format',
      weight: '4kg',
      description: 'Encyclopedie Larousse de la cuisine en 3 volumes. Recettes du monde entier. Superbes photos. Tres bel etat.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1481616756737-bc7b7b77c9ab?w=600',
      donorId: '5',
      donorName: 'Lucas Petit',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=33',
      postalCode: '75013',
      neighborhood: 'Olympiades',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),

    // ===== 75014 Montparnasse / Alesia / Plaisance =====
    Article(
      id: 'a13',
      name: 'Bureau chene massif avec tiroirs',
      category: 'Meuble',
      size: '140x70x78cm',
      weight: '40kg',
      description: 'Bureau ancien en chene massif. 3 tiroirs avec serrures. Patine naturelle. Ideal home office. A demonter pour transport.',
      condition: 'Occasion',
      photoUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=600',
      donorId: '7',
      donorName: 'Pierre Lefevre',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=60',
      postalCode: '75014',
      neighborhood: 'Montparnasse',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Article(
      id: 'a14',
      name: 'Aspirateur robot Roomba 891',
      category: 'Electromenager',
      size: 'Ø34cm',
      weight: '3kg',
      description: 'Aspirateur robot iRobot Roomba 891. Connexion Wifi. Navigation intelligente. Batterie neuve remplacee il y a 3 mois.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1589006396812-3573dd5a4f0e?w=600',
      donorId: '7',
      donorName: 'Pierre Lefevre',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=60',
      postalCode: '75014',
      neighborhood: 'Montparnasse',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
    ),
    Article(
      id: 'a15',
      name: 'Poussette Bugaboo Cameleon 3',
      category: 'Jouets',
      size: 'Standard',
      weight: '9kg',
      description: 'Poussette Bugaboo Cameleon 3 en tres bon etat. Capote et assise lavees. Toutes les pieces et adaptateurs presentes.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=600',
      donorId: '8',
      donorName: 'Claire Moreau',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=25',
      postalCode: '75014',
      neighborhood: 'Alesia',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Article(
      id: 'a16',
      name: 'Lot vetements bebe 0-6 mois fille',
      category: 'Vetements',
      size: '0-6 mois',
      weight: '500g',
      description: 'Lot de 15 pieces bebe fille. Bodies, pyjamas, chaussettes. Marques Petit Bateau et Jacadi. Laves et repasses.',
      condition: 'Neuf',
      photoUrl: 'https://images.unsplash.com/photo-1622290291165-0e6e5e98b848?w=600',
      donorId: '8',
      donorName: 'Claire Moreau',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=25',
      postalCode: '75014',
      neighborhood: 'Alesia',
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
    ),
    Article(
      id: 'a17',
      name: 'Velo de route carbone Merida',
      category: 'Sports',
      size: '54cm',
      weight: '8kg',
      description: 'Velo de route Merida Scultura cadre carbone. Groupe Shimano 105. Roues aluminium. Revision recente chez le velo-iste.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1532298229144-0ec0c57515c7?w=600',
      donorId: '9',
      donorName: 'Yves Garnier',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=57',
      postalCode: '75014',
      neighborhood: 'Plaisance',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Article(
      id: 'a18',
      name: 'Collection Asterix complete (38 albums)',
      category: 'Livres',
      size: 'Grand format',
      weight: '6kg',
      description: 'Collection complete Asterix 38 albums. Editions originales en tres bon etat. Quelques couvertures legerement abimees.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1588666309990-d68f08e3d4a6?w=600',
      donorId: '9',
      donorName: 'Yves Garnier',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=57',
      postalCode: '75014',
      neighborhood: 'Plaisance',
      createdAt: DateTime.now().subtract(const Duration(hours: 20)),
    ),

    // ===== 75015 Grenelle / Vaugirard / Beaugrenelle =====
    Article(
      id: 'a19',
      name: 'KitchenAid Artisan rouge 4.8L',
      category: 'Electromenager',
      size: '36x22x35cm',
      weight: '12kg',
      description: 'Robot patissier KitchenAid Artisan rouge. 10 vitesses, bol 4.8L. Livre avec fouet, crochet et feuille. Revision faite.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1594736797933-d0501ba2fe65?w=600',
      donorId: '10',
      donorName: 'Nadia Fontaine',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=49',
      postalCode: '75015',
      neighborhood: 'Grenelle',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    Article(
      id: 'a20',
      name: 'Tapis yoga Lululemon + accessoires',
      category: 'Sports',
      size: '183x61cm',
      weight: '2kg',
      description: 'Kit yoga complet : tapis antiderapant Lululemon, 2 blocs mousse, 1 sangle. Utilise 3 fois. Comme neuf.',
      condition: 'Neuf',
      photoUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=600',
      donorId: '10',
      donorName: 'Nadia Fontaine',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=49',
      postalCode: '75015',
      neighborhood: 'Grenelle',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Article(
      id: 'a21',
      name: 'Guitare acoustique Yamaha F310',
      category: 'Autres',
      size: 'Standard',
      weight: '3kg',
      description: 'Guitare acoustique Yamaha F310 avec etui rigide. Cordes recentes changees il y a 2 mois. Son chaleureux et equilibre.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?w=600',
      donorId: '11',
      donorName: 'Kevin Mercier',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=68',
      postalCode: '75015',
      neighborhood: 'Vaugirard',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
    ),
    Article(
      id: 'a22',
      name: 'Pack jeux de societe (6 jeux)',
      category: 'Jouets',
      size: 'Lot de 6',
      weight: '4kg',
      description: 'Lot : Catan, Ticket to Ride, Dixit, Cluedo, Uno, Dobble. Tous complets et en tres bon etat. Families bienvenue!',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1632501641765-e568d28b0015?w=600',
      donorId: '11',
      donorName: 'Kevin Mercier',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=68',
      postalCode: '75015',
      neighborhood: 'Vaugirard',
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
    ),
    Article(
      id: 'a23',
      name: 'Bibliotheque IKEA Billy blanche',
      category: 'Meuble',
      size: '80x28x202cm',
      weight: '30kg',
      description: 'Bibliotheque IKEA Billy blanche 5 tablettes. A demonter pour transport. Aucun defaut. Vendue avec toutes les chevilles.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600',
      donorId: '12',
      donorName: 'Isabelle Chevalier',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=32',
      postalCode: '75015',
      neighborhood: 'Beaugrenelle',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Article(
      id: 'a24',
      name: 'Parka Columbia imperméable - L',
      category: 'Vetements',
      size: 'L',
      weight: '1.2kg',
      description: 'Parka outdoor imperméable Columbia, doublure polaire, capuche amovible. Couleur kaki. Parfait etat pour la montagne.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1539533018447-63fcce2678e3?w=600',
      donorId: '11',
      donorName: 'Kevin Mercier',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=68',
      postalCode: '75015',
      neighborhood: 'Vaugirard',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Article(
      id: 'a25',
      name: 'Imprimante laser HP LaserJet Pro',
      category: 'Electromenager',
      size: '38x25x22cm',
      weight: '7kg',
      description: 'Imprimante laser HP LaserJet Pro. Recto-verso auto, Wi-Fi. Cartouche remplacee recemment. Fonctionne parfaitement.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?w=600',
      donorId: '12',
      donorName: 'Isabelle Chevalier',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=32',
      postalCode: '75015',
      neighborhood: 'Beaugrenelle',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Article(
      id: 'a26',
      name: 'Tapis persan laine 200x300cm',
      category: 'Autres',
      size: '200x300cm',
      weight: '8kg',
      description: 'Tapis en laine fait main, motifs floraux. Couleurs bordeaux et or. Quelques traces d usure aux angles. Authentique.',
      condition: 'Occasion',
      photoUrl: 'https://images.unsplash.com/photo-1600166898405-da9535204843?w=600',
      donorId: '12',
      donorName: 'Isabelle Chevalier',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=32',
      postalCode: '75015',
      neighborhood: 'Beaugrenelle',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  // Simule un delai reseau
  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 200));

  // Articles
  Future<RxList<Article>> getArticles({String? category, String? postalCode, String? searchQuery}) async {
    await _delay();

    List<Article> articles = _mockArticles;

    if (category != null && category != 'Tous') {
      articles = articles.where((a) => a.category == category).toList();
    }

    if (postalCode != null) {
      articles = articles.where((a) => a.postalCode == postalCode).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      articles = articles.where((a) => a.name.toLowerCase().contains(q) || a.description.toLowerCase().contains(q)).toList();
    }

    return articles.obs;
  }

  Future<Article?> getArticleById(String id) async {
    await _delay();
    try {
      return _mockArticles.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Article>> getArticlesByUser(String userId) async {
    await _delay();
    return _mockArticles.where((a) => a.donorId == userId).toList();
  }

  Future<bool> createArticle(Article article) async {
    await _delay();
    _mockArticles.add(article);
    return true;
  }

  // Users
  Future<AppUser?> getUserById(String id) async {
    await _delay();
    try {
      return _mockUsers.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<AppUser?> getCurrentUser() async {
    await _delay();
    return _mockUsers.firstWhere((u) => u.id == '2');
  }

  Future<bool> updateUser(AppUser user) async {
    await _delay();
    final index = _mockUsers.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _mockUsers[index] = user;
      return true;
    }
    return false;
  }

  // Propositions
  Future<List<Proposition>> getPropositionsForArticle(String articleId) async {
    await _delay();
    return [
      Proposition(
        id: 'p1',
        articleId: articleId,
        senderId: '1',
        senderName: 'Jean Dupont',
        senderPhotoUrl: 'https://i.pravatar.cc/150?img=11',
        message: 'Bonjour, je serais interesse par cet article!',
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }

  Future<bool> sendProposition(Proposition proposition) async {
    await _delay();
    return true;
  }

  List<String> get categories => [
        'Tous',
        'Vetements',
        'Livres',
        'Electromenager',
        'Meuble',
        'Jouets',
        'Sports',
        'Autres',
      ];

  List<String> get conditions => [
        'Neuf',
        'Bon etat',
        'Occasion',
      ];

  // ====================================================
  // CONVERSATIONS (mock data) - Marie (id=2) est le user courant
  // ====================================================
  static final List<Conversation> _mockConversations = [
    Conversation(
      id: 'c1',
      otherUserId: '1',
      otherUserName: 'Jean Dupont',
      otherUserPhotoUrl: 'https://i.pravatar.cc/150?img=11',
      articleId: 'a1',
      articleName: 'VTT Scott 26 pouces adulte',
      articlePhotoUrl: 'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=600',
      updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
      messages: [
        Message(
          id: 'm1',
          conversationId: 'c1',
          senderId: '2',
          senderName: 'Marie Martin',
          senderPhotoUrl: 'https://i.pravatar.cc/150?img=5',
          content: 'Bonjour! Je suis interessee par votre VTT, est-il encore disponible?',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: true,
        ),
        Message(
          id: 'm2',
          conversationId: 'c1',
          senderId: '1',
          senderName: 'Jean Dupont',
          senderPhotoUrl: 'https://i.pravatar.cc/150?img=11',
          content: 'Oui, bien sur! Il est en tres bon etat. Quand voulez-vous le recuperer?',
          createdAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
          isRead: true,
        ),
        Message(
          id: 'm3',
          conversationId: 'c1',
          senderId: '2',
          senderName: 'Marie Martin',
          senderPhotoUrl: 'https://i.pravatar.cc/150?img=5',
          content: 'Super! Je pourrais passer demain apres-midi si ca vous convient?',
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          isRead: true,
        ),
      ],
    ),
    Conversation(
      id: 'c2',
      otherUserId: '3',
      otherUserName: 'Thomas Bernard',
      otherUserPhotoUrl: 'https://i.pravatar.cc/150?img=15',
      articleId: 'a6',
      articleName: 'Casseroles inox - lot 12 pieces',
      articlePhotoUrl: 'https://images.unsplash.com/photo-1584990347449-a76c63db79a3?w=600',
      updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      messages: [
        Message(
          id: 'm4',
          conversationId: 'c2',
          senderId: '2',
          senderName: 'Marie Martin',
          senderPhotoUrl: 'https://i.pravatar.cc/150?img=5',
          content: 'Bonjour Thomas, les casseroles sont-elles toujours disponibles?',
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          isRead: true,
        ),
        Message(
          id: 'm5',
          conversationId: 'c2',
          senderId: '3',
          senderName: 'Thomas Bernard',
          senderPhotoUrl: 'https://i.pravatar.cc/150?img=15',
          content: 'Oui! Venez les prendre quand vous voulez. Je suis dispo ce week-end.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
      ],
    ),
  ];

  // Conversations
  Future<List<Conversation>> getConversations() async {
    await _delay();
    final sorted = List<Conversation>.from(_mockConversations)
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return sorted;
  }

  Future<void> markConversationAsRead(String conversationId) async {
    await _delay();
    final index = _mockConversations.indexWhere((c) => c.id == conversationId);
    if (index != -1) {
      for (var msg in _mockConversations[index].messages) {
        if (!msg.isMine && !msg.isRead) {
          msg.isRead = true;
        }
      }
    }
  }

  Future<Conversation?> getConversationById(String id) async {
    await _delay();
    try {
      return _mockConversations.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<Conversation> getOrCreateConversation({
    required String otherUserId,
    required String otherUserName,
    required String otherUserPhotoUrl,
    required String articleId,
    required String articleName,
    required String articlePhotoUrl,
  }) async {
    await _delay();
    try {
      return _mockConversations.firstWhere(
        (c) => c.otherUserId == otherUserId && c.articleId == articleId,
      );
    } catch (e) {
      final newConversation = Conversation(
        id: 'c${DateTime.now().millisecondsSinceEpoch}',
        otherUserId: otherUserId,
        otherUserName: otherUserName,
        otherUserPhotoUrl: otherUserPhotoUrl,
        articleId: articleId,
        articleName: articleName,
        articlePhotoUrl: articlePhotoUrl,
        messages: [],
        updatedAt: DateTime.now(),
      );
      _mockConversations.add(newConversation);
      return newConversation;
    }
  }

  Future<Message> sendMessage({
    required String conversationId,
    required String content,
    bool isExchangeProposal = false,
    String? exchangeArticleId,
    String? exchangeArticleName,
    String? exchangeArticlePhotoUrl,
  }) async {
    await _delay();
    final message = Message(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      conversationId: conversationId,
      senderId: '2',
      senderName: 'Marie Martin',
      senderPhotoUrl: 'https://i.pravatar.cc/150?img=5',
      content: content,
      createdAt: DateTime.now(),
      isRead: false,
      isExchangeProposal: isExchangeProposal,
      exchangeArticleId: exchangeArticleId,
      exchangeArticleName: exchangeArticleName,
      exchangeArticlePhotoUrl: exchangeArticlePhotoUrl,
    );

    final index = _mockConversations.indexWhere((c) => c.id == conversationId);
    if (index != -1) {
      _mockConversations[index].messages.add(message);
    }
    return message;
  }
}
