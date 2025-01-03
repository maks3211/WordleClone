import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/level_picker.dart';
import 'package:wordle_app/constants/colors.dart';
import 'package:wordle_app/pages/main_page.dart';
import 'package:wordle_app/pages/settings_page.dart';
import 'package:wordle_app/providers/level_provider.dart';
import 'package:wordle_app/providers/controller.dart';
import 'package:wordle_app/providers/theme_provider.dart';
import 'package:wordle_app/providers/user_provider.dart';

import 'package:wordle_app/utils/theme_preferences.dart';
import 'package:wordle_app/constants/themes.dart';

import 'pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LevelProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => Controller(level: 5)),    //lista providerow - elmenty ktore maja byc sluchane w provderze jest notify
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
      child: FutureBuilder(
        initialData: false,
        future: ThemePreferences.getTheme(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp){
              Provider.of<ThemeProvider>(context, listen: false).setTheme(dark: snapshot.data as bool);
            });

          }
          return Consumer<ThemeProvider>(
          builder:(_, notifier, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wordle',
            theme: notifier.isDark ? darkTheme : lightTheme,
            home: const MainPage()
              //home :HomePage(title: "Wordle"),

          ),
        );
        },
      ),
    );
  }
}

