import 'dart:convert';

class Advertise {
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final String? id;
  Advertise({
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'images': images,
      'price': price,
      'id': id,
    };
  }

  factory Advertise.fromMap(Map<String, dynamic> map) {
    return Advertise(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Advertise.fromJson(String source) =>
      Advertise.fromMap(json.decode(source));
}
