///标签
///Tag
class Tag {
  ///Count
  int count;

  ///Name
  String name;

  Tag({
    required this.count,
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        count: json["count"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "name": name,
      };
}
