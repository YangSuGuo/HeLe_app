import 'dart:convert';

import 'package:hele_app/model/images.dart';

class PersonCareer {
  List<CareerElement>? career;

  ///ID
  int? id;

  ///Images
  Images? images;

  ///Name
  String? name;

  ///Relation
  String? relation;

  ///`1`, `2`, `3` 表示 `个人`, `公司`, `组合`
  int? type;

  ///Locked
  bool? locked;

  ///Short Summary
  String? shortSummary;

  PersonCareer({
    this.career,
    this.id,
    this.images,
    this.name,
    this.relation,
    this.type,
    this.locked,
    this.shortSummary,
  });

  factory PersonCareer.fromRawJson(String str) => PersonCareer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PersonCareer.fromJson(Map<String, dynamic> json) => PersonCareer(
        career:
            List<CareerElement>.from(json["career"].map((x) => careerElementValues.map[x] ?? CareerElement.UNKNOWN)),
        id: json["id"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        name: json["name"],
        relation: json["relation"],
        type: json["type"],
        locked: json["locked"] ?? false,
        shortSummary: json["shortSummary"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "career": List<dynamic>.from(career ?? [CareerElement.UNKNOWN].map((x) => careerElementValues.reverse[x])),
        "id": id,
        "images": images?.toJson(),
        "name": name,
        "relation": relation,
        "type": type,
        "locked": locked,
        "shortSummary": shortSummary
      };
}

///PersonCareer，An enumeration.
enum CareerElement { ACTOR, ARTIST, ILLUSTRATOR, MANGAKA, PRODUCER, SEIYU, WRITER, UNKNOWN }

final careerElementValues = EnumValues({
  "actor": CareerElement.ACTOR,
  "artist": CareerElement.ARTIST,
  "illustrator": CareerElement.ILLUSTRATOR,
  "mangaka": CareerElement.MANGAKA,
  "producer": CareerElement.PRODUCER,
  "seiyu": CareerElement.SEIYU,
  "writer": CareerElement.WRITER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
