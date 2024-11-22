import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/my_single_scroll.dart';
import 'package:wordle_app/constants/colors.dart';
import 'package:wordle_app/providers/user_provider.dart';

import '../components/level_picker.dart';
import '../components/stats_list.dart';
import '../components/stats_tile.dart';
import '../components/win_chart.dart';
import '../utils/calculate_stats.dart';
import '../utils/login_storage.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  String? _selectedLogin;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statystyki'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.groups),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MySingleScroll(
                showScrollButton: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 12, 0, 0),
                      child: FutureBuilder<List<String>>(
                        future: LoginStorage().readLogins(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Gdy dane są ładowane
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // Gdy wystąpił błąd podczas ładowania
                            return Text('Błąd: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            // Gdy brak danych
                            return Text('Brak danych');
                          } else {
                            // Gdy dane zostały załadowane
                            List<String> logins = snapshot.data!;
                            String currentUsername = Provider.of<UserProvider>(
                                    context,
                                    listen: false)
                                .username;
                            if (currentUsername.isNotEmpty) {
                              logins.removeWhere(
                                  (login) => login == currentUsername);
                              if (!logins.contains("Gość")) {
                                logins.add("Gość");
                              }
                            }
                            return Center(
                              child: DropdownButton<String>(
                                value: _selectedLogin,
                                hint: const Text("Wybierz użytkownika"),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedLogin = newValue;
                                  });
                                },
                                items: logins.map<DropdownMenuItem<String>>(
                                    (String login) {
                                  return DropdownMenuItem<String>(
                                    value: login,
                                    child: Text(login),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    if (_selectedLogin != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                        child: StatsList(
                          statsFuture: getStats(
                                  user: _selectedLogin == 'Gość'
                                      ? ""
                                      : _selectedLogin!)
                              .then((value) =>
                                  value ?? ['0', '0', '0', '0', '0']),
                          headerText: "Statystyki użytkownika $_selectedLogin",
                        ),
                      ),
                  ],
                )),
            MySingleScroll(
              child: Column(
                children: [
                  Consumer<UserProvider>(
                    builder: (_, userProvider, __) {
                      String headerText = userProvider.username.isEmpty
                          ? "Statystyki Gościa"
                          : "Twoje wyniki";

                      return StatsList(
                        statsFuture: getStats(user: userProvider.username).then(
                            (value) => value ?? ['0', '0', '0', '0', '0']),
                        // Wymuszamy niemnulowalność
                        headerText:
                            headerText, // Dynamicznie ustawiony nagłówek
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: SizedBox(
                      height: 200,
                      child: WinChart(),
                    ),
                  ),
                  const SizedBox(
                    height: 90.0, // Maksymalna wysokość
                    child: LevelPicker(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


