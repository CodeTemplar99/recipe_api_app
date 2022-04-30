import 'dart:convert';

List<Recipe> recipeFromJson(String str) =>
    List<Recipe>.from(json.decode(str).map((x) => Recipe.fromJson(x)));
String recipeToJson(List<Recipe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recipe {
  Recipe({
    this.name,
    this.images,
    this.rating,
    this.totalTime,
  });

  String? name;
  String? images;
  double? rating;
  String? totalTime;

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        name: json['display']['displayName'] as String?,
        images: json['display']['images'][0] as String?,
        rating: json['display']['rating'] as double?,
        totalTime: json['display']['totalTime'] as String?);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "images": images,
        "rating": rating,
        "totalTime": totalTime,
      };

  @override
  String toString() {
    return 'Recipe {name: $name, image:$images, rating:$rating, totalTime:$totalTime}';
  }
}
