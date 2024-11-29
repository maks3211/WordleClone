import 'package:flutter/material.dart';

import 'stats_widget.dart';

class StatsList extends StatelessWidget {
  const StatsList({
    super.key,
    required this.statsFuture,
    this.headerText = "Twoje wyniki",
  });

  final Future<List<String>> statsFuture;
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: statsFuture,
      builder: (context, snapshot) {
        List<String> results = ['0', '0', '0', '0', '0'];
        if (snapshot.hasData) {
          results = snapshot.data!;
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: Text(
                headerText,

                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 30, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
            StatsWidget(
              text: "Rozegrane:",
              text2: results[0],
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              fontSize: 28,
              alignment: Alignment.centerRight,
            ),
            StatsWidget(
              text: "Wygrane:",
              text2: results[1],
              padding: EdgeInsets.fromLTRB(10, 4, 10, 0),
              fontSize: 28,
              alignment: Alignment.centerRight,
            ),
            StatsWidget(
              text: "% Wygranych:",
              text2: results[2],
              padding: EdgeInsets.fromLTRB(10, 4, 10, 0),
              fontSize: 28,
              alignment: Alignment.centerRight,
            ),
            StatsWidget(
              text: "Obecna Passa:",
              text2: results[3],
              padding: EdgeInsets.fromLTRB(10, 4, 10, 0),
              fontSize: 28,
              alignment: Alignment.centerRight,
            ),
            StatsWidget(
              text: "Najlepsza Passa:",
              text2: results[4],
              padding: EdgeInsets.fromLTRB(10, 4, 10, 50),
              fontSize: 28,
              alignment: Alignment.centerRight,
            ),
          ],
        );
      },
    );
  }
}