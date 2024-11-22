import 'dart:async';

import 'package:flutter/material.dart';

class MyAsyncTextFormField extends StatefulWidget {
  final Future<bool> Function(String) validator;
  final Duration validationDebounce;
  final TextEditingController controller;
  final String hintText;
  final String isValidatingMessage;
  final String valueIsEmptyMessage;
  final String valueIsInvalidMessage;

  /// A customizable Flutter widget for text input with asynchronous validation.
  ///
  /// This widget extends the standard TextFormField by integrating asynchronous
  /// validation capabilities, making it ideal for scenarios where you need to
  /// validate user input against external sources, such as databases or APIs.
  ///
  /// The [validator] parameter should be a function that takes the current input
  /// value and returns a Future<bool> indicating whether the input is valid.
  ///
  /// The [validationDebounce] parameter determines the debounce duration (in
  /// milliseconds) for validation requests. Validation requests will be delayed
  /// by this duration after the user stops typing, reducing the number of
  /// unnecessary calls to the validator function.
  ///
  /// The [controller] parameter is a TextEditingController that controls the
  /// content of the input field.
  ///
  /// The [isValidatingMessage] parameter allows you to customize the message
  /// displayed while validation is in progress.
  ///
  /// The [valueIsEmptyMessage] parameter allows you to customize the message
  /// displayed when the input field is empty.
  ///
  /// The [valueIsInvalidMessage] parameter allows you to customize the message
  /// displayed when the input value is considered invalid by the validator.
  ///
  /// The [hintText] parameter is optional and provides placeholder text to
  /// help users understand what type of input is expected in the field.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// AsyncTextFormField(
  ///   validator: (input) async {
  ///     // Perform asynchronous validation logic here, e.g., check if the input
  ///     // is unique in a database.
  ///     // Return true if the input is valid, false otherwise.
  ///     return await validateInputAsync(input);
  ///   },
  ///   validationDebounce: 300, // Debounce duration in milliseconds.
  ///   controller: myTextController, // A TextEditingController instance.
  ///   hintText: 'Enter a unique value',
  /// )
  /// ```
  const MyAsyncTextFormField(
      {Key? key,
        required this.validator,
        required this.validationDebounce,
        required this.controller,
        this.isValidatingMessage = "please wait for the validation to complete",
        this.valueIsEmptyMessage = 'please enter a value',
        this.valueIsInvalidMessage = 'please enter a valid value',
        this.hintText = ''})
      : super(key: key);

  @override
  _MyAsyncTextFormFieldState createState() => _MyAsyncTextFormFieldState();
}

class _MyAsyncTextFormFieldState extends State<MyAsyncTextFormField> {
  Timer? _debounce;
  var isValidating = false;
  var isValid = false;
  var isDirty = false;
  var isWaiting = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (isValidating) {
          return widget.isValidatingMessage;
        }
        if (value?.isEmpty ?? false) {
          return widget.valueIsEmptyMessage;
        }
        if (!isWaiting && !isValid) {
          return widget.valueIsInvalidMessage;
        }
        return null;
      },
      onChanged: (text) async {
        isDirty = true;
        if (text.isEmpty) {
          setState(() {
            isValid = false;
          });
          cancelTimer();
          return;
        }
        isWaiting = true;
        cancelTimer();
        _debounce = Timer(widget.validationDebounce, () async {
          isWaiting = false;
          isValid = await validate(text);
          setState(() {});
          isValidating = false;
        });
      },
      textAlign: TextAlign.start,
      controller: widget.controller,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          suffix: SizedBox(height: 20, width: 20, child: _getSuffixIcon()),
          hintText: widget.hintText),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }

  Future<bool> validate(String text) async {
    setState(() {
      isValidating = true;
    });
    final isValid = await widget.validator(text);
    isValidating = false;
    return isValid;
  }

  Widget _getSuffixIcon() {
    if (isValidating) {
      return CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(Colors.blue),
      );
    } else {
      if (!isValid && isDirty) {
        return Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid) {
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return Container();
      }
    }
  }
}
