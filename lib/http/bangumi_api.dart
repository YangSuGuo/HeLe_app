class BangumiApi {
  ///SubjectType，条目类型
  ///- `1` 为 书籍
  ///- `2` 为 动画
  ///- `3` 为 音乐
  ///- `4` 为 游戏
  ///- `6` 为 三次元
  static const String baseUrl = 'https://api.bgm.tv';

  /// 追番表
  static const String calendar = '/calendar';

  /// 条目信息
  /// /v0/subjects/{subject_id}
  /// 条目角色列表
  /// /v0/subjects/{subject_id}/characters
  /// 条目演员信息
  /// /v0/subjects/{subject_id}/persons
  /// 条目衍生
  /// /v0/subjects/{subject_id}/subjects
  static const String subject = '/v0/subjects/';

  /// 搜索
  /// POST
  /// Query 参数：
  /// limit[展示数量],offset[偏移值]
  /// Body 参数：
  /// 搜索关键字：keyword;
  /// 排序规则：sort
  /// - match 按照匹配程度 meilisearch 的默认排序，
  /// - heat 收藏人数
  /// - rank 排名由高到低
  /// - score 评分
  /// 搜索筛选 ·x 且 y·
  /// - airDate : List<String> 播出日期/发售日期,
  /// - nsfw : Bool R18,
  /// - rank : List<String> 搜索指定排名的条目,
  /// - rating : List<String> 用于搜索指定评分的条目,
  /// - tag : List<String> 标签,
  /// - type : List<int> 条目类型,
  static const String searchSubject = '/v0/search/subjects';

  /// 相关地点
  /// https://api.anitabi.cn/bangumi/${subjectID}/lite
  static const String search = 'https://api.anitabi.cn/bangumi/';
}
