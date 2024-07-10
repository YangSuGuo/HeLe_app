import 'dart:convert';

import 'package:hele_app/model/images.dart';
import 'package:hele_app/model/person_career/person_career.dart';

class CharacterList {
  ///演员列表，演员列表
  List<PersonCareer>? actors;

  ///角色ID
  int? id;

  ///角色图片
  Images? images;

  ///角色姓名
  String? name;

  ///角色定位
  String? relation;

  ///角色类型，角色，机体，舰船，组织...
  int? type;

  CharacterList({
    this.actors,
    this.id,
    this.images,
    this.name,
    this.relation,
    this.type,
  });

  factory CharacterList.fromRawJson(String str) => CharacterList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterList.fromJson(Map<String, dynamic> json) => CharacterList(
        actors:
            json["actors"] == null ? [] : List<PersonCareer>.from(json["actors"]!.map((x) => PersonCareer.fromJson(x))),
        id: json["id"] ?? 0,
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        name: json["name"] ?? "",
        relation: json["relation"] ?? '',
        type: json["type"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "actors": actors == null ? [] : List<dynamic>.from(actors!.map((x) => x.toJson())),
        "id": id,
        "images": images?.toJson(),
        "name": name,
        "relation": relation,
        "type": type,
      };
}
