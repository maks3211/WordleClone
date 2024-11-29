import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/level_picker.dart';
import 'package:wordle_app/components/stats_box.dart';
import 'package:wordle_app/data/keys_map.dart';
import 'package:wordle_app/pages/settings_page.dart';
import 'package:wordle_app/providers/level_provider.dart';
import 'package:wordle_app/providers/theme_provider.dart';

import '../components/grid.dart';
import '../components/keyboard_row.dart';
import '../constants/words.dart';
import '../providers/controller.dart';
import '../utils/quick_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _word;
  late Future<String> _wordFuture;

  @override
  void initState()
  {
    //resetGame();
    super.initState();
    int levels = Provider.of<LevelProvider>(context, listen: false).level.toInt();
    _wordFuture = fetchWord(level: levels);
  }


  void resetGame(String word) {
    // Logika do zresetowania gry
    final levels = Provider.of<LevelProvider>(context, listen: false).level;
    print("--------------WYLOSOWANE SLOWO: $word --------------");

    Provider.of<Controller>(context, listen: false).startNewGame(word: word.toUpperCase(), lvl: levels.toInt());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer<Controller>(
            builder: (_, notifier, __) {
              if (notifier.notEnoughLetters) {
                runQuickPopup(context: context, message: 'Za mało liter');
              }
              if (notifier.gameCompleted) {
                if (notifier.gameWon) {
                  runQuickPopup(context: context, message: 'Wygrana!');
                  notifier.gameCompleted = false;
                } else {
                  runQuickPopup(context: context, message: "Poprawna odpowiedź: " + notifier.correctWord);
                  notifier.gameCompleted = false;
                }
                Future.delayed(
                  const Duration(milliseconds: 4000),
                      () {
                    if (mounted) {
                      showDialog(
                          context: context, builder: (_) => const StatsBox());
                    }
                  },
                );
              }
              return IconButton(
                onPressed: () async {
                  showDialog(context: context, builder: (_) => const StatsBox());
                },
                icon: const Icon(Icons.bar_chart_outlined),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: _wordFuture, // Przyszłość, która ładuje dane
        builder: (context, snapshot) {
          // Jeśli dane są ładowane
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // Jeśli wystąpił błąd
          if (snapshot.hasError) {
            return Center(child: Text('Błąd pobierania słowa.'));
          }

          // Jeśli dane zostały załadowane
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              resetGame(snapshot.data!); // Przekazujemy pobrane słowo do resetGame
            });
            return Column(
              children: [
                Divider(),
                Expanded(flex: 7, child: Grid()),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      KeyboardRow(min: 1, max: 10),
                      KeyboardRow(min: 11, max: 19),
                      KeyboardRow(min: 20, max: 29),
                    ],
                  ),
                ),
              ],
            );
          }

          return Center(child: Text("Brak danych"));
        },
      ),
    );
  }
}




