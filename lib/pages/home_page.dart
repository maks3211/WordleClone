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

  @override
  void initState()
  {
  /*final r = Random().nextInt(words.length);   //LOSOWANIE slowa
   final v =3 + Random().nextInt(3);   //LOSOWANIE slowa
  _word = words[r];
   WidgetsBinding.instance.addPostFrameCallback((timeStamp){
    final levels = Provider.of<LevelProvider>(context, listen: false).level;
    _word = getWord(level: levels.toInt());
    print("--------------WYLOSOWANE SLOWO: $_word --------------");
    Provider.of<Controller>(context, listen: false).startNewGame(word: _word, lvl: levels.toInt());
    });*/
    resetGame();
    super.initState();

  }


  void resetGame() {
    // Logika do zresetowania gry
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){

      final levels = Provider.of<LevelProvider>(context, listen: false).level;
      _word = getWord(level: levels.toInt());
      print("--------------WYLOSOWANE SLOWO: $_word --------------");
      Provider.of<Controller>(context, listen: false).startNewGame(word: _word, lvl: levels.toInt());
    });
    print("Nowa Gra rozpoczęta!");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation:0,
        actions: [
          Consumer<Controller>(
            builder: (_, notifier, __) {
              if (notifier.notEnoughLetters) {
                runQuickPopup(context: context, message: 'Za mało liter');
              }
              if (notifier.gameCompleted) {
                if (notifier.gameWon)
                {
                    runQuickPopup(context: context, message: 'Wygrana!');
                    notifier.gameCompleted = false;
                }
                else
                {
                  runQuickPopup(context: context, message: "Poprawna odpowiedź: "+notifier.correctWord);
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
                    showDialog(
                        context: context, builder: (_) => const StatsBox());
                  },
                  icon: const Icon(Icons.bar_chart_outlined));
            },
          ),
          IconButton(onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  SettingsPage()));
          },
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: const Column(
        children: [
          Divider(),
          Expanded(
            flex : 7,
            child: Grid()),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                KeyboardRow(min: 1, max:10),
                KeyboardRow(min: 11, max:19),
                KeyboardRow(min: 20, max:29),
              ],
            )),


        ],
      )
    );
  }
}




