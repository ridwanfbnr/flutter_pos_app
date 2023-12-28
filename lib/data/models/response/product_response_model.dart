import 'dart:convert';

class ProductResponseModel {
  final bool status;
  final String message;
  final List<Product> data;

  ProductResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) {
    try {
      return ProductResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
      );
    } catch (e) {
      return ProductResponseModel(
        status: false,
        message: "Error parsing JSON data",
        data: [],
      );
    }
  }

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Product {
  final int id;
  final String name;
  final String description;
  final int price;
  final int stock;
  final Category category;
  final String image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String categoryString;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.image,
    this.createdAt,
    this.updatedAt,
  }) : categoryString =
            categoryValues.reverse[category]?.toUpperCase() ?? 'Unknown';

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        category: categoryValues.map[json["category"]]!,
        image: json["image"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "category": categoryValues.reverse[category] ?? "Unknown",
        "image": image,
        // "created_at": createdAt?.toIso8601String(),
        // "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Category { drink, food, snack }

final categoryValues = EnumValues({
  "drink": Category.drink,
  "food": Category.food,
  "snack": Category.snack,
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
