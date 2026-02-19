import 'dart:math';

import 'package:flutter/material.dart';

import 'modele.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage>
    with SingleTickerProviderStateMixin {
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

  final Random _random = Random();

  late Quote _currentQuote = _quotes[0];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _getNewQuote();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getNewQuote() async {
    var newQuote = _quotes[_random.nextInt(_quotes.length)];

    while (newQuote.text == _currentQuote.text && _quotes.length > 1) {
      newQuote = _quotes[_random.nextInt(_quotes.length)];
    }

    await _controller.reverse();

    if (!mounted) {
      return;
    }

    setState(() {
      _currentQuote = newQuote;
    });

    await _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Citations Inspirantes'),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF134E4A),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE6FFFA), Color(0xFFE0F2FE), Color(0xFFF8FAFC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF14B8A6), Color(0xFF0EA5E9)],
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 32,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x220F766E),
                              blurRadius: 28,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              color: Color(0xFF0F766E),
                              size: 42,
                            ),
                            const SizedBox(height: 18),
                            Text(
                              _currentQuote.text,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 26),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: const Color(0xFFF0FDFA),
                                border: Border.all(
                                  color: const Color(0xFF5EEAD4),
                                ),
                              ),
                              child: Text(
                                _currentQuote.author,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF115E59),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    FilledButton.icon(
                      onPressed: _getNewQuote,
                      icon: const Icon(Icons.casino_outlined),
                      label: const Text('Nouvelle citation'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
