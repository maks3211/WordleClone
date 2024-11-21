import 'package:flutter/material.dart';

import '../constants/colors.dart';

class InputBox extends StatelessWidget {
  final Color activeColor;
  final Color inactiveColor;
  final Color errorColor;
  final bool   password;
  final String text;
  final TextEditingController controller;
  const InputBox({
    super.key,
    this.activeColor = correctGreen,
    this.inactiveColor = lightThemeDarkShade,
    this.errorColor = containsYellow,
    this.password = false,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
      child: SizedBox(
        width: 300, // Szerokość TextField
        child: TextField(
          controller: controller,
          obscureText: password,
          decoration: InputDecoration(
            labelText: text,
            // Ustawienie ramki w stanie aktywnym
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)), // Zaokrąglenie rogów
              borderSide: BorderSide(
                width: 4, // Grubość ramki
                color: activeColor
              ),
            ),
            // Ustawienie ramki w stanie nieaktywnym
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 4, // Grubość ramki
                color: inactiveColor, // Kolor ramki
              ),
            ),
            // Dodatkowa ramka w przypadku błędu (opcjonalnie)
            errorBorder:  OutlineInputBorder(
              borderSide: BorderSide(
                width: 4, // Grubość ramki
                color: errorColor, // Kolor ramki
              ),
            ),
          ),
        ),
      ),
    );
  }
}