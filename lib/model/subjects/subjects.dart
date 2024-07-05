import 'dart:convert';

import 'package:hele_app/model/collection.dart';
import 'package:hele_app/model/images.dart';
import 'package:hele_app/model/infobox.dart';
import 'package:hele_app/model/rating.dart';
import 'package:hele_app/model/tag.dart';

Subjects requestFromJson(String str) => Subjects.fromJson(json.decode(str));

String requestToJson(Subjects data) => json.encode(data.toJson());

class Subjects {

  ///条目收藏人数
  Collection collection;

  ///发布日期，air date in `YYYY-MM-DD` format
  String? date;

  ///【旧】条目总集数，由旧服务端从wiki中解析，对于书籍条目为`话数`
  int eps;

  ///条目ID
  int id;

  ///条目封面集合
  Images images;

  ///条目详细信息
  List<Item>? infobox;

  ///Locked，是否锁定
  bool locked;

  ///条目原名
  String name;

  ///中文名
  String nameCn;

  ///Nsfw，是否R18
  bool nsfw;

  ///播放平台，TV, Web, 欧美剧, PS4...
  String platform;

  ///评分信息
  Rating rating;

  ///条目简介，作品的简短摘要
  String summary;

  ///标签
  List<Tag> tags;

  ///条目总集数，数据库中的章节数量
  int totalEpisodes;

  ///条目类型
  int type;

  ///Volumes，书籍条目的册数，由旧服务端从wiki中解析
  int volumes;

  Subjects({
    required this.collection,
    this.date,
    required this.eps,
    required this.id,
    required this.images,
    this.infobox,
    required this.locked,
    required this.name,
    required this.nameCn,
    required this.nsfw,
    required this.platform,
    required this.rating,
    required this.summary,
    required this.tags,
    required this.totalEpisodes,
    required this.type,
    required this.volumes,
  });

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
    collection: Collection.fromJson(json["collection"]),
    date: json["date"],
    eps: json["eps"],
    id: json["id"],
    images: Images.fromJson(json["images"]),
    infobox: json["infobox"] == null ? [] : List<Item>.from(json["infobox"]!.map((x) => Item.fromJson(x))),
    locked: json["locked"],
    name: json["name"],
    nameCn: json["name_cn"],
    nsfw: json["nsfw"],
    platform: json["platform"],
    rating: Rating.fromJson(json["rating"]),
    summary: json["summary"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    totalEpisodes: json["total_episodes"],
    type: json["type"],
    volumes: json["volumes"],
  );

  Map<String, dynamic> toJson() => {
    "collection": collection.toJson(),
    "date": date,
    "eps": eps,
    "id": id,
    "images": images.toJson(),
    "infobox": infobox == null ? [] : List<dynamic>.from(infobox!.map((x) => x.toJson())),
    "locked": locked,
    "name": name,
    "name_cn": nameCn,
    "nsfw": nsfw,
    "platform": platform,
    "rating": rating.toJson(),
    "summary": summary,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "total_episodes": totalEpisodes,
    "type": type,
    "volumes": volumes,
  };
}
