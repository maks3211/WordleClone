import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/providers/user_provider.dart';
import 'package:wordle_app/utils/calculate_chart_stats.dart';
import 'package:wordle_app/utils/calculate_stats.dart';
import 'package:wordle_app/constants/answer_stages.dart';
import 'package:wordle_app/data/keys_map.dart';
import 'package:wordle_app/models/tile_model.dart';

class Controller extends ChangeNotifier {
  bool checkLine = false,
      backOrEnterTapped = false,
      gameWon = false,
      gameCompleted = false,
      notEnoughLetters = false;
  String correctWord = "";
  int level;
  String user ="";
  int currentTile = 0, currentRow = 0;
  List<TileModel> tilesEntered = [];

Controller({required this.level});

  setLevel({required int newLevel})
  {
    level = newLevel;
    notifyListeners();
  }

  void updateUserName(String newUsername) {
    user = newUsername;
    notifyListeners(); // Powiadomienie słuchaczy o zmianie
  }

  setCorrectWord({required String word}) => correctWord = word;

  startNewGame({required String word, required int lvl}) {
    //warunek czy wznawiac gre? i jakiaś zmienna ktora zwraca czy jest w ogole taka mozliwosc
    //po to aby pokazywac przycisk
    keysMap.updateAll( (key, value) => value = AnswerStage.notAnswered);
    checkLine = false;
    backOrEnterTapped = false;
    gameWon = false;
    gameCompleted = false;
    notEnoughLetters = false;
    correctWord = "";
    currentTile = 0;
    currentRow = 0;
    tilesEntered = [];
    correctWord = word;
    level = lvl;
    notifyListeners();
  }

  setKeyTapped({required String value}) {
    if (value == 'ENTER') {
      backOrEnterTapped = true;
      if (currentTile == level * (currentRow + 1)) {
        checkWord();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      backOrEnterTapped = true;
      notEnoughLetters = false;
      if (currentTile > level * (currentRow + 1) - level) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      backOrEnterTapped = false;
      notEnoughLetters = false;
      if (currentTile < level * (currentRow + 1)) {
        tilesEntered.add(
            TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }

  checkWord() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * level; i < (currentRow * level) + level; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      for (int i = currentRow * level; i < (currentRow * level) + level; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < level; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * level)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < level; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * level)].letter) {
            if (tilesEntered[j + (currentRow * level)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * level)].answerStage =
                  AnswerStage.contains;
            }

            final resultKey = keysMap.entries.where((element) =>
            element.key == tilesEntered[j + (currentRow * level)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
      for (int i = currentRow * level; i < (currentRow * level) + level; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keysMap.entries
              .where((element) => element.key == tilesEntered[i].letter);
          if (results.single.value == AnswerStage.notAnswered) {
            keysMap.update(
                tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }
        }
      }

    }
    currentRow++;
    checkLine = true;

    //if(currentRow == level + 1 )
    if(currentRow == 6 )
      {
        gameCompleted = true;
      }
    if(gameCompleted)
      {
        calculateStats(isWin: gameWon, user:user);
        if(gameWon)
          {
            print("ZAPISYWANIE PO WYGRANEJ DLA GRACZA $user, poziom: $level");
            setChartStats(currentRow: currentRow, level: level, user: user);
          }

      }

    notifyListeners();
  }
}