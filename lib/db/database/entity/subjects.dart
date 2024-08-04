import 'package:floor/floor.dart';

class Subjects {
  ///条目 ID
  @PrimaryKey()
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

  Subjects({
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
  });
}
