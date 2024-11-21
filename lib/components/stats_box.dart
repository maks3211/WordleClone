import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/win_chart.dart';
import 'package:wordle_app/components/level_picker.dart';
import 'package:wordle_app/models/chart_model.dart';
import 'package:wordle_app/pages/home_page.dart';
import 'package:wordle_app/pages/main_page.dart';
import 'package:wordle_app/providers/level_Provider.dart';
import 'package:wordle_app/utils/calculate_stats.dart';
import 'package:wordle_app/components/stats_tile.dart';
import 'package:wordle_app/constants/answer_stages.dart';
import 'package:wordle_app/data/keys_map.dart';
import 'package:wordle_app/main.dart';
import 'package:wordle_app/utils/chart_series.dart';

import '../providers/controller.dart';
import '../providers/theme_provider.dart';









class StatsBox extends StatelessWidget {

   const StatsBox({super.key, }); //const



  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            alignment: Alignment.centerRight,
            onPressed: (){
              Navigator.maybePop(context); //zamykanie okna statystyk
            }, icon: const Icon(Icons.clear)),
           const Text("STATYSTYKI", textAlign: TextAlign.center ,style: TextStyle(fontSize: 20), ),
           Expanded(
             child: FutureBuilder(
             future: getStats(),
             builder: (context, snapshot) {
                 List<String> results = ['0','0','0','0','0',];
                 if(snapshot.hasData)
                   {
                    results = snapshot.data as List<String>;
                   }
               return Row(
              children: [
                StatsTile(value : int.parse(results[0]), valueName:  "Rozegrane", fontSize: 50),
                StatsTile(value : int.parse(results[2]), valueName:  "%\nWygranych", fontSize: 15),
                StatsTile(value : int.parse(results[3]), valueName:  "Obenca\nPassa", fontSize: 30),
                StatsTile(value : int.parse(results[4]), valueName:  "Najlepsza\nPassa", fontSize: 50),
              ],
                       );
             },
           ),),

          const SizedBox(width: 1, height: 200,  child: WinChart()),
          const Expanded(child: LevelPicker()),
          Expanded(child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(title: "Wordle")),
                      (route) => route.settings.name == '/' // Zachowuje MainPage
              );
             // Navigator.of(context).pop(); // Zamyka StatsBox
              //rowiazanie pierwotne
             // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
            },
            child: Text("Nowa Gra",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 30,
              ),
            ),
            ),
          ),

        ],
      ),

    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );
}

