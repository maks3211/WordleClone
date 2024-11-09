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