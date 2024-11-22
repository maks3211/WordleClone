import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class LoginStorage {
   String filePath;

  // Prywatny konstruktor
  LoginStorage._privateConstructor(this.filePath);

  // Statyczna instancja Singleton (pierwsze wywołanie z parametrem)
  static LoginStorage? _instance;

  // Fabryczna metoda z możliwością przekazania filePath
  factory LoginStorage() {
    _instance ??= LoginStorage._privateConstructor('');
    return _instance!;
  }

  // Ustawienie domyślnej ścieżki pliku w folderze aplikacji
  Future<void> _initializeFilePath() async {
    if (filePath.isEmpty) {
      final directory = await getApplicationDocumentsDirectory();  // Pobiera odpowiedni folder dla danej platformy
      _instance?.filePath = '${directory.path}/logins.json'; // Definiowanie pełnej ścieżki
    }
  }

  /// Odczytuje listę loginów z pliku JSON.
  Future<List<String>> readLogins() async {
    await _initializeFilePath();
    final file = File(filePath);
    // Sprawdzanie, czy plik istnieje
    if (!await file.exists()) {
      return []; // Zwraca pustą listę, jeśli plik nie istnieje
    }

    try {
      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);
      return data.cast<String>(); // Konwersja na listę loginów
    } catch (e) {
      print('Błąd odczytu danych: $e');
      return [];
    }
  }

  /// Zapisuje listę loginów do pliku JSON.
  Future<void> writeLogins(List<String> logins) async {
    await _initializeFilePath();
    final file = File(filePath);

    try {
      final jsonData = json.encode(logins);
      await file.writeAsString(jsonData, flush: true); // Zapis danych
    } catch (e) {
      print('Błąd zapisu danych: $e');
    }
  }

  /// Dodaje nowy login do listy.
  Future<void> addLogin(String login) async {
    final logins = await readLogins();

    // Sprawdzanie, czy login już istnieje
    if (logins.contains(login)) {
      throw Exception('Login już istnieje.');
    }

    logins.add(login);
    await writeLogins(logins);
  }

  /// Sprawdza, czy login istnieje.
  Future<bool> loginExists(String login) async {
    final logins = await readLogins();
    return logins.contains(login);
  }
}
