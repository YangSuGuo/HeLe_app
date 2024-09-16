class HttpString {
  static const String apiBaseUrl = 'https://api.bgm.tv';
  static const Map<String, String> headers = {
    'Host': 'api.bgm.tv',
    'User-Agent': 'YangSuGuo/HeLe/1.0.0 (https://github.com/YangSuGuo/HeLe_app)',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'app-id': 'bgm3063662e1d8747988',
    'app-secret': '427cfed140895351b35c06d45c1ef6e6',
    // 'Authorization': 'Bearer 427cfed140895351b35c06d45c1ef6e6',
  };
  static const Duration connectTimeout = Duration(milliseconds: 12000);
  static const List<int> validateStatusCodes = [
    302,
    304,
    307,
    400,
    401,
    403,
    404,
    405,
    409,
    412,
    500,
    503,
    504,
    509,
    616,
    617,
    625,
    626,
    628,
    629,
    632,
    643,
    650,
    652,
    658,
    662,
    688,
    689,
    701,
    799,
    8888
  ];
}
