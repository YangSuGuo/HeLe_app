import 'package:floor/floor.dart';
import 'package:hele_app/db/database/entity/subjects.dart';

@Entity(tableName: 'subjects_history')
class SubjectsHistory extends Subjects {
  late final int creationTime;

  SubjectsHistory({
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
    required this.creationTime,
  });
}
