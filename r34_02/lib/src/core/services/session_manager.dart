import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _keyIsLoggedIn = 'is_logged_in';

  final SharedPreferences _prefs;

  SessionManager(this._prefs);

  /// Call this after a successful login or register.
  Future<void> markLoggedIn() async {
    await _prefs.setBool(_keyIsLoggedIn, true);
  }

  /// Call this on logout.
  Future<void> clearSession() async {
    await _prefs.remove(_keyIsLoggedIn);
  }

  /// Synchronous, safe to read at app start.
  bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;
}
