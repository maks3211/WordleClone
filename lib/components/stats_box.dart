import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/components/level_picker.dart';
import 'package:wordle_app/models/chart_model.dart';
import 'package:wordle_app/pages/home_page.dart';
import 'package:wordle_app/utils/calculate_stats.dart';
import 'package:wordle_app/components/stats_tile.dart';
import 'package:wordle_app/constants/answer_stages.dart';
import 'package:wordle_app/data/keys_map.dart';
import 'package:wordle_app/main.dart';
import 'package:wordle_app/utils/chart_series.dart';

import '../providers/controller.dart';
import '../providers/theme_provider.dart';









class StatsBox extends StatelessWidget {

   const StatsBox({super.key}); //const




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
                StatsTile(value : int.parse(results[0]), valueName:  "Rozegrane"),
                StatsTile(value : int.parse(results[2]), valueName:  "%\nWygranych"),
                StatsTile(value : int.parse(results[3]), valueName:  "Obenca\nPassa"),
                StatsTile(value : int.parse(results[4]), valueName:  "Najlepsza\nPassa"),
              ],
                       );
             },
           ),),
          SizedBox(
            height: 320,
            width: 100,
            child: FutureBuilder<List<BarChartGroupData>>(
              future: getSeries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Błąd: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final series = snapshot.data!;
                  return BarChart(
                    BarChartData(
                      barTouchData: barTouchData,
                      barGroups: series,
                      titlesData: const FlTitlesData(
                          show: true,
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles( showTitles: false)
                      ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)
                        ),
                        topTitles: AxisTitles(
                          sideTitles:  SideTitles(showTitles:  false)
                        )
                      ),
                      // dodaj tytuły, jeśli chcesz
                      borderData: FlBorderData(show: false),
                      gridData:  const FlGridData(show: false)// usuń obramowanie, jeśli niepotrzebne
                    ),
                  );
                } else {
                  return const SizedBox(); // Pusty widget w przypadku braku danych
                }
              },
            ),
          ),
          Expanded(child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: (){
              keysMap.updateAll( (key, value) => value = AnswerStage.notAnswered);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
            },
              child: const Text('Nowa Gra', style: TextStyle(fontSize: 30)),
            ),
          ),
          const Expanded(child: LevelPicker()),//aktualnie działa na zasaszie zamkniecia wszystkiego do momentu gdy jest na tym oknie z main
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

