import 'dart:convert';

///评分
///评分信息
class Rating {
  ///各分段的评分次数
  Count count;

  ///排名
  int? rank;

  ///平均分
  double score;

  ///总评分人
  int total;

  Rating({
    required this.count,
    this.rank,
    required this.score,
    required this.total,
  });

  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        count: Count.fromJson(json["count"]),
        rank: json["rank"],
        score: json["score"]?.toDouble(),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "count": count.toJson(),
        "rank": rank,
        "score": score,
        "total": total,
      };
}

///各分值评分人数
class Count {
  late int the1;
  late int the10;
  late int the2;
  late int the3;
  late int the4;
  late int the5;
  late int the6;
  late int the7;
  late int the8;
  late int the9;

  Count({
    required this.the1,
    required this.the10,
    required this.the2,
    required this.the3,
    required this.the4,
    required this.the5,
    required this.the6,
    required this.the7,
    required this.the8,
    required this.the9,
  });

  factory Count.fromRawJson(String str) => Count.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        the6: json["6"],
        the7: json["7"],
        the8: json["8"],
        the9: json["9"],
        the10: json["10"],
      );

  List<int> toList() => [
        the1 ?? 0,
        the2 ?? 0,
        the3 ?? 0,
        the4 ?? 0,
        the5 ?? 0,
        the6 ?? 0,
        the7 ?? 0,
        the8 ?? 0,
        the9 ?? 0,
        the10 ?? 0,
      ];

  Map<String, dynamic> toJson() => {
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "6": the6,
        "7": the7,
        "8": the8,
        "9": the9,
        "10": the10,
      };
}
