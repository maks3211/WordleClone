import 'package:shared_preferences/shared_preferences.dart';

calculateStats({required bool isWin}) async{
  int gamesPlayed = 0;
  int gamesWon = 0;
  int winPercentage = 0;
  int currentStreak = 0;
  int maxStreak = 0;

  final stats = await getStats();
  if(stats != null)
    {
    gamesPlayed = int.parse(stats[0]);
    gamesWon = int.parse(stats[1]);
    winPercentage = int.parse(stats[2]);
    currentStreak = int.parse(stats[3]);
    maxStreak = int.parse(stats[4]);
    }
  gamesPlayed++;
  if(isWin)
    {
      gamesWon++;
      currentStreak++;
    }
  else
    {
      currentStreak = 0;
    }
  if(currentStreak > maxStreak)
    {
     maxStreak = currentStreak;
    }

  winPercentage = ( (gamesWon / gamesPlayed) * 100).toInt();

  final preferences = await SharedPreferences.getInstance();
  preferences.setStringList('stats',
  [
    gamesPlayed.toString(),
    gamesWon.toString(),
    winPercentage.toString(),
    currentStreak.toString(),
    maxStreak.toString(),
  ]);
}

///Returns a list of statistics -> for now there is just a one player, later it's should check player name
Future<List<String>?>getStats () async{
  final preferences = await SharedPreferences.getInstance();
  final stats = preferences.getStringList('stats');
  if(stats != null)
    {
    return stats;
    }
    else
    {
      return null;
    }
}