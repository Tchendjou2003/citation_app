

import 'package:citation_app/CitationPage.dart';

// Import du framework Flutter et des composants Material (boutons, textes, etc.)
import 'package:flutter/material.dart';

// Fonction principale : point d'entrée de l'application Flutter.
// `runApp` démarre l'application et prend en paramètre le widget racine.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Titre de l'application (utilisé par l'OS)
      title: 'Citations Inspirantes',
      // Supprime la bannière DEBUG en haut à droite en mode debug
      debugShowCheckedModeBanner: false,
      // Configuration du thème global de l'application
      theme: ThemeData(
        // Police par défaut
        fontFamily: 'Montserrat',
        // Génère un jeu de couleurs à partir d'une couleur de base
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        // Active le style Material 3 
        useMaterial3: true,
      ),
      // L'écran de départ de l'application
      home: const QuotePage(),
    );
  }
}



