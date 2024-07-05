import 'dart:convert';

///评分
class Rating {
  ///各分值评分人数
  Count? count;

  ///评分
  double? score;

  ///总评分人数
  int? total;

  Rating({
    this.count,
    this.score,
    this.total,
  });

  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        count: json["count"] == null ? null : Count.fromJson(json["count"]),
        score: json["score"]?.toDouble(),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "count": count?.toJson(),
        "score": score,
        "total": total,
      };
}

///各分值评分人数
class Count {
  int? the1;
  int? the10;
  int? the2;
  int? the3;
  int? the4;
  int? the5;
  int? the6;
  int? the7;
  int? the8;
  int? the9;

  Count({
    this.the1,
    this.the10,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
  });

  factory Count.fromRawJson(String str) => Count.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        the1: json["1"],
        the10: json["10"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        the6: json["6"],
        the7: json["7"],
        the8: json["8"],
        the9: json["9"],
      );

  Map<String, dynamic> toJson() => {
        "1": the1,
        "10": the10,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "6": the6,
        "7": the7,
        "8": the8,
        "9": the9,
      };
}
