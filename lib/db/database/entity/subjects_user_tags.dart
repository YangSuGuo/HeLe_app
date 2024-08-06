import 'package:floor/floor.dart';

@Entity(tableName: 'subjects_user_tags')
class SubjectsUserTags {
  @PrimaryKey(autoGenerate: true)
  late final int? tagId;
  late String tag;
  late final int creationTime;

  late final bool? isHidden; // 是否隐藏
  late final bool? isPinned; // 是否置顶

  SubjectsUserTags({
    this.tagId,
    required this.tag,
    required this.creationTime,
    this.isHidden,
    this.isPinned,
  });
}
