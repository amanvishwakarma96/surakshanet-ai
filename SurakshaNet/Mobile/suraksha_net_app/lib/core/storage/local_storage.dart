import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async => (await SharedPreferences.getInstance()).setString(_tokenKey, token);
  Future<String?> readToken() async => (await SharedPreferences.getInstance()).getString(_tokenKey);
  Future<void> clear() async => (await SharedPreferences.getInstance()).clear();
}
