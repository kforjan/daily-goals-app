import 'package:shared_preferences/shared_preferences.dart';

class SpData {
  static Future<void> saveData(String key, bool value) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(key, value);
  }

  static Future<List<String>> getAllKeys() async {
    final _prefs = await SharedPreferences.getInstance();
    final keysSet = _prefs.getKeys();
    final keys = keysSet.toList();
    return keys;
  }

  static Future<bool> isGoalDone(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    final isDone = _prefs.getBool(key);
    return isDone;
  }

  static Future<void> deleteData(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
    print('removed');
  }
}
