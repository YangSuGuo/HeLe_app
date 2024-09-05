import 'dart:convert';

List<CharacterInvolvement> characterInvolvementFromJson(String str) =>
    List<CharacterInvolvement>.from(json.decode(str).map((x) => CharacterInvolvement.fromJson(x)));

String characterInvolvementToJson(List<CharacterInvolvement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// 角色参与作品
class CharacterInvolvement {
  ///条目ID
  int id;

  // 条目类型
  int type;

  ///条目封面图
  String? image;

  ///条目原名
  String? name;

  ///条目中文名
  String nameCn;

  ///角色定位
  String staff;

  CharacterInvolvement({
    required this.id,
    required this.type,
    this.image,
    this.name,
    required this.nameCn,
    required this.staff,
  });

  factory CharacterInvolvement.fromJson(Map<String, dynamic> json) => CharacterInvolvement(
        id: json["id"],
        type: json["type"],
        image: json["image"],
        name: json["name"],
        nameCn: json["name_cn"],
        staff: json["staff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "image": image,
        "name": name,
        "name_cn": nameCn,
        "staff": staff,
      };
}
