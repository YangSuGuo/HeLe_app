import 'package:floor/floor.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';

@dao
abstract class SubjectsStarDao {
  // 查询全部收藏
  @Query('SELECT * FROM subjects_star')
  Future<List<SubjectsStar>> findAllSubjectsStar();

  /// 按照 条目类型 条目状态 用户标签 是否隐藏  查询收藏
  /// 设置排序规则
  /// - 默认：按照创建时间进行倒序排序
  /// - 评分：按照用户评分进行倒序排序
  @Query('''
      SELECT * FROM subjects_star
        WHERE type = :type 
        AND status = :status 
        AND (tags LIKE :tags OR :tags IS NULL) 
        AND isHidden = :isHidden
      ORDER BY :sortBy DESC
      LIMIT 20 OFFSET :offset;
  ''')
  Future<List<SubjectsStar>> findSubjectsStarByTypeStatusTagsHidden(
      String type,
      String status,
      String tags,
      bool isHidden,
      String sortBy,
      int offset,
      );

  // 添加收藏
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addSubject(SubjectsStar subject);

  // 取消收藏
  @delete
  Future<void> removeSubject(SubjectsStar subject);

  // 更新收藏
  @update
  Future<int> updateSubject(SubjectsStar subject);
}
