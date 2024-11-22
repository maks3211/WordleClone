import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePreferencesHelper {

  final FlutterSecureStorage _storage = FlutterSecureStorage();
  SecurePreferencesHelper._privateConstructor();
  static SecurePreferencesHelper? _instance;
  factory SecurePreferencesHelper() {
    _instance ??= SecurePreferencesHelper._privateConstructor();
    return _instance!;
  }

  Future<void> writeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  Future<String?> readData(String key) async {
    return await _storage.read(key: key);
  }
  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }
  Future<void> clearAll({required bool delete}) async {
    if(delete)
    {
      await _storage.deleteAll();
    }
  }


  Future<void> saveLoginCredentials(String username, String password) async {
    await _storage.write(key: 'password_$username', value: password);
  }

  Future<String?> getLoginCredentials(String username) async {
    final storedPassword = await _storage.read(key: 'password_$username');
    return storedPassword;
  }



  Future<void> clearLoginCredentials(String username) async {
    await _storage.delete(key: 'username_$username');
    await _storage.delete(key: 'password_$username');
  }

  Future<bool> userExists(String username) async {
    final storedUsername = await _storage.read(key: 'username_$username');
    return storedUsername != null;
  }
}