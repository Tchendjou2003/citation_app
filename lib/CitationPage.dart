import 'package:flutter/material.dart';
import 'modele.dart';
import 'dart:math';


class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  _QuotePageState createState() => _QuotePageState();
}


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

  
  late Quote _currentQuote = _quotes[0];

  
  final Random _random = Random();

  // Contrôleur d'animation pour gérer l'effet d'apparition/disparition.
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;


  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
   
    _getNewQuote();
  }

  // Méthode pour obtenir une nouvelle citation aléatoire.
  void _getNewQuote() async {
    
    var newQuote = _quotes[_random.nextInt(_quotes.length)];

   
    while (newQuote.text == _currentQuote.text && _quotes.length > 1) {
      newQuote = _quotes[_random.nextInt(_quotes.length)];
    }

    
    _controller.reverse();
    
    await Future.delayed(const Duration(milliseconds: 250));

    setState(() {
      _currentQuote = newQuote;
    });

    _controller.forward();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        elevation: 0, 
        centerTitle: true, 
        title: const Text(
          'Citations Inspirantes',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.teal.shade800, 
      ),
    
      body: Container(
  
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0), 
          child: Center(
            
            child: FadeTransition(
              opacity: _fadeAnimation,
             
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
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
