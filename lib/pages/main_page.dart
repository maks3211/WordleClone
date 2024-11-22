import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/level_picker.dart';
import 'package:wordle_app/pages/home_page.dart';

import 'package:wordle_app/pages/settings_page.dart';
import 'package:wordle_app/pages/stats_page.dart';
import 'package:wordle_app/providers/controller.dart';
import 'package:wordle_app/providers/user_provider.dart';

import 'login_reg_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wordle"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                return Text(
                  userProvider.username.isNotEmpty
                      ? userProvider.username
                      : 'Gość',
                  style: TextStyle(fontSize: 18),
                );
              }),
            ),
          ],
        ),
        body: Column(
          children: [
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  "Menu Główne",
                  style: TextStyle(
                    fontSize: 34,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    minimumSize: Size(200, 60)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage(title: "Wordle")));
                },
                child: Text(
                  "Nowa Gra",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
            ),
            const Expanded(child: LevelPicker()),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    minimumSize: Size(200, 60)),
                onPressed: () {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  if (userProvider.username.isEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginRegPage()));
                  } else {
                    print("WYLOGGUJ");
                    Provider.of<UserProvider>(context, listen: false)
                        .setUserName("");
                    Provider.of<Controller>(context, listen: false)
                        .updateUserName("");
                  }
                },
                child: Text(
                  Provider.of<UserProvider>(context, listen: true).isLogged
                      ? "Wyloguj"
                      : "Zaloguj",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    minimumSize: Size(200, 60)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StatsPage()));
                },
                child: Text(
                  "Statystyki",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    minimumSize: Size(200, 60)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                child: Text(
                  "Ustawienia",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
            ),
          ],
        ));
  }
}
