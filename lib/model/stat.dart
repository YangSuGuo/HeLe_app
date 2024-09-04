///角色评论与收藏
///
///Stat
class Stat {
  ///收藏数量
  int collects;

  ///评论数量
  int comments;

  Stat({
    required this.collects,
    required this.comments,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        collects: json["collects"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "collects": collects,
        "comments": comments,
      };
}
