import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_app/helpers/preferences_helper.dart';
//uzywane tylko w momencie gdy jest wygrana gra - wywolywane w controller
setChartStats({required int currentRow, required int level, required String user})async
{
  List<int> distribution = [0,0,0,0,0,0];

  final stats = await getStats(level: level, user: user);

  if(stats != null)
    {
      distribution = stats;
    }

  for(int i = 0; i < level + 1; i++)
    {
    if(currentRow - 1 == i)
      {
        distribution[i]++;
      }
    }


  List<String> stringList = distribution.map((number) => number.toString()).toList();
  //final preferences = await SharedPreferences.getInstance();
  final preferences = await SharedPreferencesHelper.instance;
  //zapisanie 1- w którym rzedzie wygrana aktualna gra 2- przechowuje liste ilosci
  //wszystkiech wyhranych w danej probie
  preferences.setInt('row', currentRow);
  preferences.setStringList('chart$level$user', stringList);

}


Future<List<int>?> getStats({required int level, required String user}) async {
 // final prefs = await SharedPreferences.getInstance();
  final prefs = await SharedPreferencesHelper.instance;
  final stats = prefs.getStringList('chart$level$user');
  List<int> result = [];
  if (stats != null)
  {
    for (var e in stats)
    {
      result.add(int.parse(e));
    }
    return result;
  }
  else
  {
    for (var i = 0; i < 6; i++) {
      result.add(i);
    }
  }
  return null;
}