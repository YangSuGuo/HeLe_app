import 'package:floor/floor.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';

@dao
abstract class SubjectsStarDao {
  // 查询全部
  @Query('SELECT * FROM subjects_star')
  Future<List<SubjectsStar>> findAllSubjectsStar();

  /// 按照 条目类型 条目状态 用户标签 是否隐藏 是否收藏 查询数据库
  /// 设置排序规则
  /// - 默认：按照创建时间进行倒序排序
  /// - 评分：按照用户评分进行倒序排序
  @Query('''
      SELECT * FROM subjects_star
        WHERE type = :type 
        AND status = :status 
        AND (tags LIKE :tags OR :tags IS NULL) 
        AND isHidden = :isHidden
        AND isCollected = :isCollected
      ORDER BY :sortBy DESC
      LIMIT 20 OFFSET :offset;
  ''')
  Future<List<SubjectsStar>> findSubjectsStarByTypeStatusTagsHidden(
    String type,
    String status,
    String tags,
    bool isHidden,
    bool isCollected,
    String sortBy,
    int offset,
  );

  // 根据 条目ID 查询条目是否存在 返回布尔值
  @Query('SELECT EXISTS(SELECT 1 FROM subjects_star WHERE subjectId = :subjectId)')
  Future<bool?> isSubjectExists(int subjectId);

  // 根据 条目ID 与 是否收藏 同时满足 查询条目是否存在 返回布尔值
  @Query('SELECT EXISTS(SELECT 1 FROM subjects_star WHERE subjectId = :subjectId AND isCollected = :isCollected)')
  Future<bool?> isSubjectCollectedById(
    int subjectId,
    bool isCollected,
  );

  // 根据 条目ID 指定 tags列 返回数据
  @Query('SELECT tags FROM subjects_star WHERE subjectId = :subjectId')
  Future<String?> getTagsForSubject(int subjectId);

  // 添加
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addSubject(SubjectsStar subject);

  // 取消
  @delete
  Future<void> removeSubject(SubjectsStar subject);

  // 更新
  @update
  Future<int> updateSubject(SubjectsStar subject);
}
