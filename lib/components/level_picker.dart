import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/stats_box.dart';
import 'package:wordle_app/providers/controller.dart';


class LevelPicker extends StatefulWidget {
  const LevelPicker({super.key});

  @override
  State<LevelPicker> createState() => _LevelPickerState();
}

class _LevelPickerState extends State<LevelPicker> {
  double _currentSliderValue = 3;

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        // Zaktualizuj wartość slidera na podstawie wartości w kontrolerze
       // _currentSliderValue = notifier.se.toDouble();
        return Slider(
          value: _currentSliderValue,
          min: 3,
          max: 8,
          divisions: 5,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              // Zaktualizuj poziom w kontrolerze
             // notifier.setLevel(newLevel: value.round());

            });
          },
        );
      },
    );
  }
}
