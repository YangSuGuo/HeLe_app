import 'dart:convert';

class Images {
  String? common;
  String? grid;
  String? large;
  String? medium;
  String? small;

  Images({
    this.common,
    this.grid,
    this.large,
    this.medium,
    this.small,
  });

  Images.allSame(String imageUrl)
      : common = imageUrl,
        grid = imageUrl,
        large = imageUrl,
        medium = imageUrl,
        small = imageUrl;

  factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        common: json["common"],
        grid: json["grid"],
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "grid": grid,
        "large": large,
        "medium": medium,
        "small": small,
      };
}
