import 'package:flutter/material.dart';

class FramedText extends StatelessWidget {
  final String text;
  final List<Color> borderColors; // Lista kolorów dla ramki
  final double squareSize;
  final double letterSpacing;

  FramedText({super.key,
    required this.text,
    required this.borderColors,
    this.squareSize = 50.0,
    this.letterSpacing = 8.0, // Przerwa między literami
  }) : assert(borderColors.length == text.length, 'Number of border colors must match the number of letters.');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Aby nie zajmować całej szerokości ekranu
      children: text.split('').asMap().map((index, letter) {
        // Dla każdej litery przypisujemy odpowiedni kolor z listy borderColors
        return MapEntry(
          index,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: letterSpacing / 2), // Przerwa między literami
            child: Container(
              width: squareSize * 1.08, // Szerokość kwadratu
              height: squareSize * 1.08, // Wysokość kwadratu

              decoration: BoxDecoration(
                color: borderColors[index],
                border: Border.all(color: borderColors[index], width: 2.0),
              ),
              alignment: Alignment.center, // Wyrównanie tekstu w środku kontenera
              child: Text(
                letter,
                style: TextStyle(fontSize: squareSize * 0.4), // Dostosowanie rozmiaru tekstu do rozmiaru kwadratu
              ),
            ),
          ),
        );
      }).values.toList(),
    );
  }
}