
//Ta biblioteka nie działa już -> trzeeba skorzystac z fl charts - wszystko jest juz zainstalowane


import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_app/constants/colors.dart';
import 'package:wordle_app/helpers/preferences_helper.dart';
import 'package:wordle_app/models/chart_model.dart';


Future<List<BarChartGroupData>> getSeries({required int level, required String user}) async
{

List<ChartModel> data = [];
//  preferences = await SharedPreferences.getInstance();
final preferences = await SharedPreferencesHelper.instance;
final scores = preferences.getStringList('chart$level$user');
final row = preferences.getInt('row');
if(scores == null)
  {
    for (var i = 0; i < 6; i++) {
      data.add(ChartModel(score: 0, currentGame: false));
    }
  }

if (scores != null)
  {
    for(var e in scores)
      {
        data.add(ChartModel(score: int.parse(e), currentGame: false));
      }
  }
if (row != null && row > 0)
  {
    data[row - 1].currentGame = true;
  }
List<BarChartGroupData> barGroups = data.asMap().entries.map((entry){
  int index = entry.key;
  ChartModel model = entry.value;
  return BarChartGroupData(
    showingTooltipIndicators: [0],
    x: index + 1,
    barRods: [
      BarChartRodData(toY: model.score.toDouble(),
      color: model.currentGame ? const Color(0xFF6BAA64) : const Color(0xFF3F453F),
          width: 22,
      ),
    ]
  );
}).toList();
return barGroups;
}