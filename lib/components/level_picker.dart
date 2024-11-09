import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/stats_box.dart';
import 'package:wordle_app/pages/home_page.dart';
import 'package:wordle_app/providers/level_provider.dart';
import 'package:wordle_app/providers/controller.dart';


class LevelPicker extends StatefulWidget {
  const LevelPicker({super.key});

  @override
  State<LevelPicker> createState() => _LevelPickerState();
}

class _LevelPickerState extends State<LevelPicker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LevelProvider>(builder: (_, notifier, __) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Poziom: ${notifier.level.toInt()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: notifier.level,
            min: 4,
            max: 8,
            divisions: 4,
            onChanged: (double value) {
              notifier.updateLevel(value);
            },
          ),
        ],
      );
    });
  }
}


/* Stara wersja tej klasy - brak synchronizacji pomiędzy różnymi widokami
class LevelPicker extends StatefulWidget {
  const LevelPicker({super.key});

  @override
  State<LevelPicker> createState() => _LevelPickerState();
}

class _LevelPickerState extends State<LevelPicker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LevelProvider>(builder: (_, notifier, __) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Poziom: ${notifier.level.toInt()}', // Użyj wartości z provider
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: notifier.level,
            min: 3,
            max: 8,
            divisions: 5,
            onChanged: (double value) {
              notifier.updateLevel(value); // Zaktualizuj poziom w provider
            },
          ),
        ],
      );
    });
  }
}*/
