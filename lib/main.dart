

import 'package:citation_app/CitationPage.dart';


import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      title: 'Citations Inspirantes',
    
      debugShowCheckedModeBanner: false,
     
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
     
        useMaterial3: true,
      ),
     
      home: const QuotePage(),
    );
  }
}



