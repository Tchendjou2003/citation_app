import 'package:flutter/material.dart';
import 'modele.dart';
import 'dart:math';

// QuotePage est un StatefulWidget car il doit changer quand l'utilisateur
// demande une nouvelle citation.
class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  _QuotePageState createState() => _QuotePageState();
}

// La classe d'état qui contient les données et la logique de l'écran.
// SingleTickerProviderStateMixin permet d'utiliser un AnimationController.
class _QuotePageState extends State<QuotePage>
    with SingleTickerProviderStateMixin {
  // Liste typée des citations
  final List<Quote> _quotes = [
    const Quote(
      text:
          'La seule façon de faire du bon travail, c’est d’aimer ce que vous faites.',
      author: 'Steve Jobs',
    ),
    const Quote(
      text: 'L’innovation distingue un leader d’un suiveur.',
      author: 'Steve Jobs',
    ),
    const Quote(
      text: 'Ne cherche pas le succès, cherche à être utile.',
      author: 'Albert Einstein',
    ),
    const Quote(
      text: 'L’esprit est tout. Ce que tu penses, tu le deviens.',
      author: 'Bouddha',
    ),
    const Quote(
      text: 'Une vie sans examen ne vaut pas la peine d’être vécue.',
      author: 'Socrate',
    ),
    const Quote(
      text:
          'Votre temps est limité, ne le gâchez pas en vivant la vie de quelqu’un d’autre.',
      author: 'Steve Jobs',
    ),
    const Quote(
      text:
          'L’avenir appartient à ceux qui croient en la beauté de leurs rêves.',
      author: 'Eleanor Roosevelt',
    ),
    const Quote(
      text: 'Croyez en vous et tout deviendra possible.',
      author: 'Audrey Hepburn',
    ),
    const Quote(
      text: 'Chaque jour est une nouvelle chance de changer ta vie.',
      author: 'Anonyme',
    ),
  ];

  // Citation actuellement affichée, initialisée à la première citation.
  late Quote _currentQuote = _quotes[0];

  // Réutiliser une seule instance de Random pour les tirages aléatoires.
  final Random _random = Random();

  // Contrôleur d'animation pour gérer l'effet d'apparition/disparition.
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // initState est appelé une seule fois lorsque le widget est inséré
  // dans l'arbre de widgets. On y initialise le contrôleur d'animation
  // et on sélectionne une citation initiale.
  @override
  void initState() {
    super.initState();
    // AnimationController permet de piloter une animation. vsync évite
    // les animations inutiles quand l'écran n'est pas visible.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // CurvedAnimation applique une courbe (accélération/décélération)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    // Choisit une citation au lancement
    _getNewQuote();
  }

  // Méthode pour obtenir une nouvelle citation aléatoire.
  void _getNewQuote() async {
    // Random permet de choisir un index aléatoire dans la liste.
    // Choix d'un nouvel index aléatoire en réutilisant _random
    var newQuote = _quotes[_random.nextInt(_quotes.length)];

    // Boucle pour éviter de choisir la même citation que celle
    // actuellement affichée (si la liste contient plus d'une citation).
    while (newQuote.text == _currentQuote.text && _quotes.length > 1) {
      newQuote = _quotes[_random.nextInt(_quotes.length)];
    }

    // Lance l'animation de sortie (fade out)
    _controller.reverse();
    // Attend une petite pause pour que la disparition soit visible
    await Future.delayed(const Duration(milliseconds: 250));

    // Met à jour l'état : nouvelle citation. setState indique à Flutter
    // qu'il doit reconstruire l'interface.
    setState(() {
      _currentQuote = newQuote;
    });

    // Lance l'animation d'apparition (fade in)
    _controller.forward();
  }

  // build construit l'interface chaque fois que l'état change.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Couleur de fond générale de l'écran
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        elevation: 0, // pas d'ombre sous l'AppBar
        centerTitle: true, // centre le titre horizontalement
        title: const Text(
          'Citations Inspirantes',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent, // rendu transparent
        foregroundColor: Colors.teal.shade800, // couleur des icônes/texte
      ),
      // Le corps principal de l'écran
      body: Container(
        // Decoration pour un fond en dégradé
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0), // marge intérieure
          child: Center(
            // FadeTransition relie l'opacité à l'animation
            child: FadeTransition(
              opacity: _fadeAnimation,
              // Column pour empiler les widgets verticalement
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Card : panneau avec ombre pour mettre en valeur la citation
                  Card(
                    elevation: 10,
                    shadowColor: Colors.teal.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          // Icône de guillemet pour l'aspect visuel
                          Icon(
                            Icons.format_quote,
                            color: Colors.teal.shade400,
                            size: 48,
                          ),
                          const SizedBox(height: 20), // espace vertical
                          // Texte de la citation
                          Text(
                            _currentQuote.text,
                            style: const TextStyle(
                              fontSize: 22,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          // Auteur de la citation
                          Text(
                            '- ${_currentQuote.author}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Bouton pour générer une nouvelle citation
                  ElevatedButton.icon(
                    onPressed: _getNewQuote, // appelle la méthode ci-dessus
                    icon: const Icon(Icons.autorenew),
                    label: const Text('Nouvelle citation'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade400,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
