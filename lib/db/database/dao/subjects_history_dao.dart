import 'package:floor/floor.dart';
import 'package:hele_app/db/database/entity/subjects_history.dart';

@dao
abstract class SubjectsHistoryDao {
  // 查询全部
  @Query('SELECT * FROM subjects_history')
  Future<List<SubjectsHistory>> findAllSubjectsHistory();
}
