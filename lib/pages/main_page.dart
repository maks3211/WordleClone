import 'package:flutter/material.dart';
import 'package:wordle_app/components/level_picker.dart';
import 'package:wordle_app/pages/home_page.dart';
import 'package:wordle_app/pages/settings_page.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wordle"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              "Menu Główne",
              style: TextStyle(
                fontSize: 34,
              ),
            ),
          ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                 child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white12, minimumSize: Size(200,60)),
                 
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(title: "Wordle")));
                    },
                    child: Text("Nowa Gra",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                      ),
                   ),
                  ),
               ),
          const Expanded(child: LevelPicker()),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      )
    );
  }
}
