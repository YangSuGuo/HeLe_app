import 'package:floor/floor.dart';
import 'package:hele_app/db/database/entity/subjects.dart';

@Entity(tableName: 'subjects_star')
class SubjectsStar extends Subjects {
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

  SubjectsStar({
    required super.subjectId,
    required super.name,
    required super.nameCn,
    required super.type,
    super.url,
    required super.platform,
    super.summary,
    super.totalEpisodes,
    super.volumes,
    super.eps,
    super.airDate,
    super.images,
    super.score,
    super.rank,
    //////////////////////////////////
    this.isHidden,
    required this.status,
    required this.rating,
    this.tags,
    this.isCollected,
    required this.creationTime,
  });
}
