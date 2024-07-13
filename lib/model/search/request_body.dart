import 'dart:convert';

class RequestBody {

  ///不同条件之间是 `且` 的关系
  Filter? filter;
  String keyword;

  ///排序规则
  ///
  ///- `match` meilisearch 的默认排序，按照匹配程度
  ///- `heat` 收藏人数
  ///- `rank` 排名由高到低
  ///- `score` 评分
  Sort? sort;

  RequestBody({
    this.filter,
    required this.keyword,
    this.sort,
  });

  factory RequestBody.fromRawJson(String str) => RequestBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestBody.fromJson(Map<String, dynamic> json) => RequestBody(
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    keyword: json["keyword"],
    sort: sortValues.map[json["sort"]]!,
  );

  Map<String, dynamic> toJson() => {
    "filter": filter?.toJson(),
    "keyword": keyword,
    "sort": sortValues.reverse[sort],
  };
}


///不同条件之间是 `且` 的关系
class Filter {

  ///播出日期/发售日期，日期必需为 `YYYY-MM-DD` 格式。多值之间为 `且` 关系。
  List<String>? airDate;

  ///无权限的用户会直接忽略此字段，不会返回R18条目。
  ///
  ///默认或者 `null` 会返回包含 R18 的所有搜索结果。
  ///
  ///`true` 只会返回 R18 条目。
  ///
  ///`false` 只会返回非 R18 条目。
  bool? nsfw;

  ///用于搜索指定排名的条目，多值之间为 `且` 关系。
  List<String>? rank;

  ///用于搜索指定评分的条目，多值之间为 `且` 关系。
  List<String>? rating;

  ///标签，可以多次出现。多值之间为 `且` 关系。
  List<String>? tag;

  ///条目类型，参照 `SubjectType` enum，多值之间为 `或` 的关系。
  List<int>? type;

  Filter({
    this.airDate,
    this.nsfw,
    this.rank,
    this.rating,
    this.tag,
    this.type,
  });

  factory Filter.fromRawJson(String str) => Filter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    airDate: json["air_date"] == null ? [] : List<String>.from(json["air_date"]!.map((x) => x)),
    nsfw: json["nsfw"],
    rank: json["rank"] == null ? [] : List<String>.from(json["rank"]!.map((x) => x)),
    rating: json["rating"] == null ? [] : List<String>.from(json["rating"]!.map((x) => x)),
    tag: json["tag"] == null ? [] : List<String>.from(json["tag"]!.map((x) => x)),
    type: json["type"] == null ? [] : List<int>.from(json["type"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "air_date": airDate == null ? [] : List<dynamic>.from(airDate!.map((x) => x)),
    "nsfw": nsfw,
    "rank": rank == null ? [] : List<dynamic>.from(rank!.map((x) => x)),
    "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
    "tag": tag == null ? [] : List<dynamic>.from(tag!.map((x) => x)),
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
  };
}


///排序规则
///
///- `match` meilisearch 的默认排序，按照匹配程度
///- `heat` 收藏人数
///- `rank` 排名由高到低
///- `score` 评分
enum Sort {
  HEAT,
  MATCH,
  RANK,
  SCORE
}

final sortValues = EnumValues({
  "heat": Sort.HEAT,
  "match": Sort.MATCH,
  "rank": Sort.RANK,
  "score": Sort.SCORE
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
