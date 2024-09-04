import 'dart:convert';

import 'package:hele_app/model/images.dart';
import 'package:hele_app/model/stat.dart';

WikiDetail wikiDetailFromJson(String str) => WikiDetail.fromJson(json.decode(str));

String wikiDetailToJson(WikiDetail data) => json.encode(data.toJson());

///Request
///
///CharacterDetail
class WikiDetail {
  ///角色出生了日份，parsed from wiki, maybe `null`
  int? birthDay;

  ///角色出生月份，parsed from wiki, maybe `null`
  int? birthMon;

  ///角色出生年份，parsed from wiki, maybe `null`
  int? birthYear;

  ///角色血型，“1，2，3，4”表示“A，B，AB，O”` 从wiki解析，可能为null，
  int? bloodType;

  ///角色性别，从wiki解析，可能为null
  String? gender;

  ///角色ID
  int id;

  ///角色头图，object with some size of images, this object maybe `null`
  Images? images;

  ///角色详细信息，服务器解析的infobox，从键到字符串或元组的映射
  ///如果服务器信息框无效，则为null
  List<Map<String, dynamic>>? infobox;

  ///是否锁定
  bool locked;

  ///角色姓名
  String name;

  ///角色评论与收藏
  Stat stat;

  ///角色简介
  String summary;

  ///角色类型，角色，机体，舰船，组织...
  int type;

  WikiDetail({
    this.birthDay,
    this.birthMon,
    this.birthYear,
    this.bloodType,
    this.gender,
    required this.id,
    this.images,
    this.infobox,
    required this.locked,
    required this.name,
    required this.stat,
    required this.summary,
    required this.type,
  });

  factory WikiDetail.fromJson(Map<String, dynamic> json) => WikiDetail(
        birthDay: json["birth_day"],
        birthMon: json["birth_mon"],
        birthYear: json["birth_year"],
        bloodType: json["blood_type"],
        gender: json["gender"],
        id: json["id"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        infobox: json["infobox"] == null
            ? []
            : List<Map<String, dynamic>>.from(
                json["infobox"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        locked: json["locked"],
        name: json["name"],
        stat: Stat.fromJson(json["stat"]),
        summary: json["summary"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "birth_day": birthDay,
        "birth_mon": birthMon,
        "birth_year": birthYear,
        "blood_type": bloodType,
        "gender": gender,
        "id": id,
        "images": images?.toJson(),
        "infobox": infobox == null
            ? []
            : List<dynamic>.from(infobox!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "locked": locked,
        "name": name,
        "stat": stat.toJson(),
        "summary": summary,
        "type": type,
      };
}
