import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String name;
  final String reference;
  final String unit;
  final int currentStock;
  final String category;
  final DateTime lastUpdated;
  final String service;

  Product({
    String? id,
    required this.name,
    required this.reference,
    required this.unit,
    required this.currentStock,
    required this.category,
    DateTime? lastUpdated,
    required this.service,
  })  : id = id ?? const Uuid().v4(),
        lastUpdated = lastUpdated ?? DateTime.now();

  // Convert a Product into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'reference': reference,
      'unit': unit,
      'currentStock': currentStock,
      'category': category,
      'lastUpdated': lastUpdated.toIso8601String(),
      'service': service,
    };
  }

  // Create a Product from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      reference: map['reference'],
      unit: map['unit'],
      currentStock: map['currentStock'],
      category: map['category'],
      lastUpdated: DateTime.parse(map['lastUpdated']),
      service: map['service'],
    );
  }

  // Create a copy of the product with updated fields
  Product copyWith({
    String? name,
    String? reference,
    String? unit,
    int? currentStock,
    String? category,
    String? service,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      reference: reference ?? this.reference,
      unit: unit ?? this.unit,
      currentStock: currentStock ?? this.currentStock,
      category: category ?? this.category,
      lastUpdated: DateTime.now(),
      service: service ?? this.service,
    );
  }
}

// Categories de produits
enum ProductCategory {
  cleaning('Nettoyage', 0xFF4CAF50), // Vert
  stationery('Papeterie', 0xFF2196F3), // Bleu
  kitchen('Cuisine', 0xFF9C27B0), // Violet
  other('Autre', 0xFFFF9800); // Orange

  final String displayName;
  final int color;
  const ProductCategory(this.displayName, this.color);

  static ProductCategory fromString(String value) {
    return ProductCategory.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => ProductCategory.other,
    );
  }
}
