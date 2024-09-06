import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/model/character_list/character_list.dart';
import 'package:hele_app/model/derivation/related_works_query.dart';
import 'package:hele_app/model/person_career/person_career.dart';

class ExtendedList extends StatefulWidget {
  const ExtendedList({super.key});

  @override
  State<ExtendedList> createState() => _ExtendedListState();
}

class _ExtendedListState extends State<ExtendedList> {
  late int type; // 类型
  late String header;
  late List<CharacterList> characters; // 角色列表
  late List<PersonCareer> persons; // 演员信息
  late List<RelatedWorksQuery> derivation; // 衍生条目

  // List<PersonCareer>? actors; // 演员列表

  late int length;
  late Widget Function(BuildContext, int) itemBuilder;

  @override
  void initState() {
    super.initState();
    type = Get.arguments['type'];
    switch (type) {
      case 1:
        characters = Get.arguments['list'];
        length = characters.length;
        header = "角色列表";
        itemBuilder = (context, index) {
          return ListItem(
            img: characters[index].images!.large ?? "",
            title: "${characters[index].relation}：${characters[index].name!}",
            actors: characters[index].actors,
          );
        };
        break;
      case 2:
        persons = Get.arguments['list'];
        length = persons.length;
        header = "演员信息";
        itemBuilder = (context, index) {
          return ListItem(
            img: persons[index].images!.large ?? "",
            title: "${persons[index].relation}：${persons[index].name!}",
          );
        };
        break;
      case 3:
        derivation = Get.arguments['list'];
        length = derivation.length;
        header = "衍生条目";
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.08),
            width: 1,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: Text(
          header,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView.builder(
        itemCount: length,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

// 角色&人物展示
class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.img,
    required this.title,
    this.actors,
  });

  final String img;
  final String title;
  final List<PersonCareer>? actors;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: NetworkImg(
        src: img,
        width: 40,
        height: 80,
        fit: BoxFit.contain,
      ),
      title: AutoSizeText(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: actors != null ? person(actors) : null,
    );
  }

  // 演员列表
  Widget person(List<PersonCareer>? actors) {
    return SizedBox(
        height: 80.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actors?.length ?? 0,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  NetworkImg(
                    src: actors?[index].images?.large,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 5),
                  AutoSizeText(
                    actors?[index].name ?? "",
                  ),
                ],
              );
            }));
  }
}
