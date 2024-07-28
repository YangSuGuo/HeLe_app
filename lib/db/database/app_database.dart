import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hele_app/db/database/dao/subjects_star_dao.dart';
import 'package:hele_app/db/database/dao/subjects_user_tags_dao.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [SubjectsStar, SubjectsUserTags])
abstract class AppDatabase extends FloorDatabase {
  // 用户收藏
  SubjectsStarDao get subjectsStarDao;

  // 用户标签
  SubjectsUserTagsDao get subjectsUserTagsDao;

  // 清空所有表
  Future<void> clearAllTables() async {
    await database.execute('DELETE FROM subjects_star');
    await database.execute('DELETE FROM subjects_user_tags');
  }
}
