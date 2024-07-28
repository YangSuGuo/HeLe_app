import 'package:floor/floor.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';

@dao
abstract class SubjectsUserTagsDao {
  // 查询并全部的 Tags
  @Query('SELECT * FROM subjects_user_tags')
  Future<List<SubjectsUserTags>> findAllTags();

  // 添加 Tag
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTag(SubjectsUserTags tag);

  // 更新 Tag
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTag(SubjectsUserTags tag);

  // 删除 Tag
  @delete
  Future<void> deleteTag(SubjectsUserTags tag);
}
