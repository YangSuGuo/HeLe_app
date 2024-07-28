import 'package:floor/floor.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';

@dao
abstract class SubjectsStarDao {
  // 查询全部收藏
  @Query('SELECT * FROM subjects_star')
  Future<List<SubjectsStar>> findAllSubjectsStar();
}
