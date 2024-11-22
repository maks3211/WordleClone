import 'package:flutter/material.dart';

import '../constants/colors.dart';

class InputBox extends StatelessWidget {
  final Color activeColor;
  final Color inactiveColor;
  final Color errorColor;
  final bool password;
  final String text;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool autoValidate;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  const InputBox({
    super.key,
    this.activeColor = correctGreen,
    this.inactiveColor = lightThemeDarkShade,
    this.errorColor = containsYellow,
    this.password = false,
    required this.text,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.autoValidate = false,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
      child: SizedBox(
        width: 300,
        child: TextFormField(

          controller: controller,
          obscureText: password,
          validator: validator,
          autovalidateMode: autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: text,
            errorText: errorText,
            // Warunkowe ustawienie ramki
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                width: 4,
                color: activeColor, // Jeśli jest błąd, pozostaje czerwona ramka
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                width: 4,
                color: inactiveColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                width: 4,
                color: errorColor,
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}