import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';

class UserTagsControllers extends GetxController
    with GetTickerProviderStateMixin {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例
  Rx<TextEditingController> controller = TextEditingController().obs;

  RxList<SubjectsUserTags> tags = <SubjectsUserTags>[].obs;
  RxString tag = "".obs;

  @override
  void onInit() async {
    super.onInit();
    if (false) {
      SubjectsUserTags tags = SubjectsUserTags(
        tag: "·测试-1·",
        creationTime: DateTime.now().millisecondsSinceEpoch,
      );

      await db.subjectsUserTagsDao.insertTag(tags);
    }
  }

  // 初始化
  void onClear() {
    controller.value.clear();
    tag.value = '';
  }

  // 编辑 & 添加
  void editTag(bool isEdit, SubjectsUserTags? tags) {
    if (isEdit) {
      // 添加
      if (tag.trim().isNotEmpty) {
        insertSubjectsUserTags();
        SmartDialog.dismiss(force: true);
      } else {
        onClear();
        SmartDialog.showToast("标签不能为空");
      }
    } else {
      // 编辑
      if (tag.trim().isNotEmpty && tags != null) {
        tags.tag = tag.value;
        updateSubjectsUserTags(tags);
        SmartDialog.dismiss(force: true);
      } else {
        onClear();
        SmartDialog.showToast("标签不能为空");
      }
    }
    querySubjectsUserTags();
    // SmartDialog.dismiss(force: true);
  }

  // 查询所有标签
  Future<List<SubjectsUserTags>> querySubjectsUserTags() async {
    tags.value = await db.subjectsUserTagsDao.findAllTags();
    return tags;
  }

  // 删除标签
  Future<void> deleteSubjectsUserTags(SubjectsUserTags tag) async {
    await db.subjectsUserTagsDao.deleteTag(tag);
  }

  // 添加标签
  Future<void> insertSubjectsUserTags() async {
    SubjectsUserTags userTag = SubjectsUserTags(
      tag: tag.value,
      creationTime: DateTime.now().millisecondsSinceEpoch,
    );
    onClear();
    await db.subjectsUserTagsDao.insertTag(userTag);
  }

  // 更新标签
  Future<void> updateSubjectsUserTags(SubjectsUserTags userTag) async {
    onClear();
    await db.subjectsUserTagsDao.updateTag(userTag);
  }
}
