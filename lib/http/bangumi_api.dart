class BangumiApi {
  static const String baseUrl = 'https://api.bgm.tv';

// 追番表
  static const String calendar = '/calendar';

  // 条目信息
  // /v0/subjects/{subject_id}
  // 条目角色列表
  // /v0/subjects/{subject_id}/characters
  // 条目演员信息
  // /v0/subjects/{subject_id}/persons
  // 条目衍生
  // /v0/subjects/{subject_id}/subjects
  static const String subject = '/v0/subjects/';

  // 搜索
  static const String searchSubject = '/v0/search/subjects';

  // 相关地点
  // https://api.anitabi.cn/bangumi/${subjectID}/lite
  static const String search = 'https://api.anitabi.cn/bangumi/';
}
