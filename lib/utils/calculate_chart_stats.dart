import 'package:shared_preferences/shared_preferences.dart';
//uzywane tylko w momencie gdy jest wygrana gra - wywolywane w controller
setChartStats({required int currentRow, required int level})async
{
  List<int> distribution = [0,0,0,0,0,0];

  final stats = await getStats();

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
  final preferences = await SharedPreferences.getInstance();
  //zapisanie 1- w którym rzedzie wygrana aktualna gra 2- przechowuje liste ilosci
  //wszystkiech wyhranych w danej probie
  preferences.setInt('row', currentRow);
  preferences.setStringList('chart', stringList);

}


Future<List<int>?> getStats() async {
  final prefs = await SharedPreferences.getInstance();
  final stats = prefs.getStringList('chart');
  if (stats != null) {
    List<int> result = [];
    for (var e in stats) {
      result.add(int.parse(e));
    }
    return result;
  } else {
    return null;
  }

}