import 'dart:convert';

import 'package:http/http.dart' as http;


Future<String> fetchWord({required int level}) async{
  final response = await http.get(Uri.parse('https://random-word-api.vercel.app/api?words=1&length=$level'));
  if(response.statusCode == 200)
    {
      final List<dynamic> words = jsonDecode(response.body);
      return words[0]; // Zwracamy pierwsze słowo w liście
    }
  else
    {
      print("NIE UDALO SIE TEGO ZALADOWAC");
      return "STORM";
    }
}

const List<String> words =
[
  'PIZZA'
];



String getWord({required int level})
{
  switch (level)
  {
    case 3:
      return 'DRY';
    case 4:
      return 'BULK';
    case 5:
      return 'STORM';
      case 6:
        return 'SPRING';
    case 7:
      return 'JANITOR';
    case 8:
      return 'STARSHIP';
    default:
      return 'STORM';
  }

}