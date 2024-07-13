import 'dart:convert';

import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/images.dart';
import 'package:hele_app/model/rating.dart';
import 'package:hele_app/model/tag.dart';

class Datum {
  ///上映/开播/连载开始日期，可能为空字符串
  String date;

  ///条目ID
  int id;

  ///封面
  String image;

  ///条目原名
  String name;

  ///条目中文名
  String nameCn;

  ///排名
  int rank;

  ///评分
  double score;

  ///条目描述
  String summary;
  List<Tag> tags;
  int? type;

  Datum({
    required this.date,
    required this.id,
    required this.image,
    required this.name,
    required this.nameCn,
    required this.rank,
    required this.score,
    required this.summary,
    required this.tags,
    this.type,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        id: json["id"],
        image: json["image"],
        name: json["name"],
        nameCn: json["name_cn"],
        rank: json["rank"],
        score: json["score"]?.toDouble(),
        summary: json["summary"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "id": id,
        "image": image,
        "name": name,
        "name_cn": nameCn,
        "rank": rank,
        "score": score,
        "summary": summary,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "type": type,
      };
  // 新增转换方法
  LegacySubjectSmall toLegacySubjectSmall() {
    return LegacySubjectSmall(
      airDate: date.isNotEmpty ? date : null,
      id: id,
      images: Images.allSame(image),
      name: name,
      nameCn: nameCn,
      rank: rank,
      summary: summary,

      // 缺少字段
      rating: null,
      type: null,
      eps: null,
      epsCount: null,
      collection: null,
      url: null,

    );
  }
}
