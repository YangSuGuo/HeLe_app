abstract class PreferenceManager {

  static const keyToken = "token"; // token
  static const appThemes = "themes"; // app主题

  // APP 基础配置

  // todo 本地持久化配置

  // 基础 CRUD
  Future<String> getString(String key, {String defaultValue = ""});

  Future<bool> setString(String key, String value);

  Future<int> getInt(String key, {int defaultValue = 0});

  Future<bool> setInt(String key, int value);

  Future<double> getDouble(String key, {double defaultValue = 0.0});

  Future<bool> setDouble(String key, double value);

  Future<bool> getBool(String key, {bool defaultValue = false});

  Future<bool> setBool(String key, bool value);

  Future<List<String>> getStringList(String key,
      {List<String> defaultValue = const []});

  Future<bool> setStringList(String key, List<String> value);

  Future<bool> remove(String key);

  Future<bool> clear();
}
