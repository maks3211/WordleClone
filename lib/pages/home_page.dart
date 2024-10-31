import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/stats_box.dart';
import 'package:wordle_app/data/keys_map.dart';
import 'package:wordle_app/pages/settings_page.dart';
import 'package:wordle_app/providers/theme_provider.dart';

import '../components/grid.dart';
import '../components/keyboard_row.dart';
import '../constants/words.dart';
import '../providers/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late String _word;

  @override
  void initState()
  {
    final r = Random().nextInt(words.length);   //LOSOWANIE slowa
    _word = words[r];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation:0,
        actions: [
          IconButton(onPressed: (){
          showDialog(context: context, builder: (_) => StatsBox());
          }, icon: const Icon(Icons.bar_chart)),
          IconButton(onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  SettingsPage()));
          },
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: const Column(
        children: [
          Divider(),
          Expanded(
            flex : 7,
            child: Grid()),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                KeyboardRow(min: 1, max:10),
                KeyboardRow(min: 11, max:19),
                KeyboardRow(min: 20, max:29),
              ],
            )),


        ],
      )
    );
  }
}




