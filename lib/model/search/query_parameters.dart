import 'dart:convert';

class QueryParameters {
  int limit;
  int offset;

  QueryParameters({
    required this.limit,
    required this.offset,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
      };
}
