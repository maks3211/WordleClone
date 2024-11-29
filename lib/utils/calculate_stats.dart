import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_app/helpers/preferences_helper.dart';

calculateStats({required bool isWin, required String user}) async{
  int gamesPlayed = 0;
  int gamesWon = 0;
  int winPercentage = 0;
  int currentStreak = 0;
  int maxStreak = 0;

  final stats = await getStats(user : user);
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

 // final preferences = await SharedPreferences.getInstance();
  final preferences = await SharedPreferencesHelper.instance;
  preferences.setStringList('stats$user',
  [
    gamesPlayed.toString(),
    gamesWon.toString(),
    winPercentage.toString(),
    currentStreak.toString(),
    maxStreak.toString(),
  ]);
}

///Returns a list of statistics -> for now there is just a one player, later it's should check player name
Future<List<String>?>getStats ({required String user}) async{
  //final preferences = await SharedPreferences.getInstance();
  final preferences = await SharedPreferencesHelper.instance;
  final stats = preferences.getStringList('stats$user');
  if(stats != null)
    {
    return stats;
    }
    else
    {
      return null;
    }
}