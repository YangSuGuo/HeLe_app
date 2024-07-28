import 'package:floor/floor.dart';

@Entity(tableName: 'subjects_user_tags')
class SubjectsUserTags {
  @PrimaryKey(autoGenerate: true)
  late final int? tagId;
  late final String tag;
  late final int creationTime;

  late final bool? isHidden;
  late final bool? isPinned;

  SubjectsUserTags({
    this.tagId,
    required this.tag,
    required this.creationTime,

    this.isHidden,
    this.isPinned,
  });
}
