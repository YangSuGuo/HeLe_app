import 'dart:convert';

import 'package:hele_app/model/search/search.dart';

class Pagination {
  List<Datum>? data;

  ///当前分页参数
  int? limit;

  ///当前分页参数
  int? offset;

  ///搜索结果数量
  int? total;

  Pagination({
    this.data,
    this.limit,
    this.offset,
    this.total,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "limit": limit,
        "offset": offset,
        "total": total,
      };
}
