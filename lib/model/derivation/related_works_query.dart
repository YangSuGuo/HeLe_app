import 'dart:convert';

import 'package:hele_app/model/images.dart';

class RelatedWorksQuery {
  ///ID
  int id;

  ///Images
  Images? images;

  ///Name
  String name;

  ///Name Cn
  String? nameCn;

  ///Relation
  String? relation;

  ///Type
  int type;

  RelatedWorksQuery({
    required this.id,
    this.images,
    required this.name,
    this.nameCn,
    this.relation,
    required this.type,
  });

  factory RelatedWorksQuery.fromRawJson(String str) =>
      RelatedWorksQuery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RelatedWorksQuery.fromJson(Map<String, dynamic> json) =>
      RelatedWorksQuery(
        id: json["id"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        name: json["name"],
        nameCn: json["name_cn"],
        relation: json["relation"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": images?.toJson(),
        "name": name,
        "name_cn": nameCn,
        "relation": relation,
        "type": type,
      };
}
