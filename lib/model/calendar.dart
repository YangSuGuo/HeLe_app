import 'dart:convert';

import 'package:hele_app/model/rating.dart';

import 'collection.dart';
import 'images.dart';

class Calendar {
  List<LegacySubjectSmall>? items;
  Weekday? weekday;

  Calendar({
    this.items,
    this.weekday,
  });

  factory Calendar.fromRawJson(String str) => Calendar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
    items: json["items"] == null ? [] : List<LegacySubjectSmall>.from(json["items"]!.map((x) => LegacySubjectSmall.fromJson(x))),
    weekday: json["weekday"] == null ? null : Weekday.fromJson(json["weekday"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "weekday": weekday?.toJson(),
  };
}


///Legacy_SubjectSmall
class LegacySubjectSmall {

  ///放送开始日期
  String? airDate;

  ///放送星期
  int? airWeekday;

  ///收藏人数
  Collection? collection;

  ///话数
  int? eps;

  ///话数
  int? epsCount;

  ///条目 ID
  int? id;

  ///封面
  Images? images;

  ///条目名称
  String? name;

  ///条目中文名称
  String? nameCn;

  ///排名
  int? rank;

  ///评分
  Rating? rating;

  ///剧情简介
  String? summary;

  ///SubjectType，条目类型
  ///- `1` 为 书籍
  ///- `2` 为 动画
  ///- `3` 为 音乐
  ///- `4` 为 游戏
  ///- `6` 为 三次元
  ///
  ///没有 `5`
  int? type;

  ///条目地址
  String? url;

  LegacySubjectSmall({
    this.airDate,
    this.airWeekday,
    this.collection,
    this.eps,
    this.epsCount,
    this.id,
    this.images,
    this.name,
    this.nameCn,
    this.rank,
    this.rating,
    this.summary,
    this.type,
    this.url,
  });

  factory LegacySubjectSmall.fromRawJson(String str) => LegacySubjectSmall.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LegacySubjectSmall.fromJson(Map<String, dynamic> json) => LegacySubjectSmall(
    airDate: json["air_date"],
    airWeekday: json["air_weekday"],
    collection: json["collection"] == null ? null : Collection.fromJson(json["collection"]),
    eps: json["eps"],
    epsCount: json["eps_count"],
    id: json["id"],
    images: json["images"] == null ? null : Images.fromJson(json["images"]),
    name: json["name"],
    nameCn: json["name_cn"],
    rank: json["rank"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
    summary: json["summary"],
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "air_date": airDate,
    "air_weekday": airWeekday,
    "collection": collection?.toJson(),
    "eps": eps,
    "eps_count": epsCount,
    "id": id,
    "images": images?.toJson(),
    "name": name,
    "name_cn": nameCn,
    "rank": rank,
    "rating": rating?.toJson(),
    "summary": summary,
    "type": type,
    "url": url,
  };
}

class Weekday {
  String? cn;
  String? en;
  int? id;
  String? ja;

  Weekday({
    this.cn,
    this.en,
    this.id,
    this.ja,
  });

  factory Weekday.fromRawJson(String str) => Weekday.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weekday.fromJson(Map<String, dynamic> json) => Weekday(
    cn: json["cn"],
    en: json["en"],
    id: json["id"],
    ja: json["ja"],
  );

  Map<String, dynamic> toJson() => {
    "cn": cn,
    "en": en,
    "id": id,
    "ja": ja,
  };
}