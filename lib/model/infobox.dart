///条目详细信息
///Item
class Item {
  ///Key
  String key;

  ///Value
  dynamic value;

  Item({
    required this.key,
    required this.value,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
