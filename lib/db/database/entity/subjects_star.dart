import 'package:floor/floor.dart';

@Entity(tableName: 'subjects_star')
class SubjectsStar {
  @PrimaryKey(autoGenerate: true)
  late final int? id;

  ///条目 ID
  late final int subjectId;

  ///条目名称
  late final String name;

  late final String nameCn;

  ///条目类型
  late final int type;

  ///条目地址
  late final String? url;

  ///播放平台，TV, Web, 欧美剧, PS4...
  late final String platform;

  ///剧情简介
  late final String? summary;

  ///话数
  late final int? totalEpisodes;
  late final int? volumes;
  late final int? eps;

  ///放送开始日期
  late final String? airDate;

  ///封面
  late final String? images;

  ///评分
  late final double? score;
  late final int? rank;

///////////////////////////////////////////////
  /// 是否隐藏
  late final bool? isHidden;

  /// 当前状态
  /// - 0: 未开始
  /// - 1: 进行中
  /// - 2: 已完成
  /// - 3: 搁置
  /// - 4: 抛弃
  late final int status;

  /// 用户评分
  late final double rating;

  /// 用户标签
  late final String? tags;

  /// 是否收藏
  late final bool? isCollected;

  /// 创建时间
  late final int creationTime;

///////////////////////////////////////////////

  SubjectsStar({
    this.id,
    required this.subjectId,
    required this.name,
    required this.nameCn,
    required this.type,
    this.url,
    required this.platform,
    this.summary,
    this.totalEpisodes,
    this.volumes,
    this.eps,
    this.airDate,
    this.images,
    this.score,
    this.rank,
    this.isHidden,
    required this.status,
    required this.rating,
    this.tags,
    this.isCollected,
    required this.creationTime,
  });
}
