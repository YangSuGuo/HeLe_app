import 'package:floor/floor.dart';
import 'package:hele_app/db/database/entity/subjects.dart';
import 'package:hele_app/model/search/search.dart';
import 'package:hele_app/model/tag.dart';

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

  Datum toDatum() {
    return Datum(
      date: airDate ?? "",
      id: subjectId,
      image: url ?? "",
      name: name,
      nameCn: nameCn,
      rank: rank ?? 0,
      score: score ?? 0.0,
      summary: summary ?? '',
      tags: [],
      type: type,
    );
  }
}
