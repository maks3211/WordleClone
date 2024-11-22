import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final String text; // Treść tekstu
  final String text2;
  final double fontSize; // Rozmiar czcionki
  final EdgeInsets padding; // Padding
  final Alignment alignment;

  const StatsWidget(
      {super.key,
        required this.text,
        required this.text2,
        this.fontSize = 12, // Rozmiar czcionki
        this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0), // Domyślny padding
        this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                softWrap: false,
                text,
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: fontSize,
                ),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.right,
                text2,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}