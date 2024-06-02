import 'dart:convert';

///收藏人数
class Collection {

  ///做过
  int? collect;

  ///在做
  int? doing;

  ///抛弃
  int? dropped;

  ///搁置
  int? onHold;

  ///想做
  int? wish;

  Collection({
    this.collect,
    this.doing,
    this.dropped,
    this.onHold,
    this.wish,
  });

  factory Collection.fromRawJson(String str) => Collection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    collect: json["collect"],
    doing: json["doing"],
    dropped: json["dropped"],
    onHold: json["on_hold"],
    wish: json["wish"],
  );

  Map<String, dynamic> toJson() => {
    "collect": collect,
    "doing": doing,
    "dropped": dropped,
    "on_hold": onHold,
    "wish": wish,
  };
}