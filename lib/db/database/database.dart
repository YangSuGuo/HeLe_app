import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hele_app/db/database/dao/subjects_star_dao.dart';
import 'package:hele_app/db/database/dao/subjects_user_tags_dao.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [SubjectsStar, SubjectsUserTags])
abstract class AppDatabase extends FloorDatabase {
  SubjectsStarDao get subjectsStarDao;

  SubjectsUserTagsDao get subjectsUserTagsDao;
}
