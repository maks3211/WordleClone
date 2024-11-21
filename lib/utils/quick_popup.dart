import 'package:flutter/material.dart';

runQuickPopup({required BuildContext context, required String message}) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 1200), () {
            Navigator.maybePop(context);
          });
          return AlertDialog(
            title: Text(
              message,
              textAlign: TextAlign.center,
            ),
          );
        });
  });
}