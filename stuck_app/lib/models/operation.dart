import 'package:uuid/uuid.dart';

enum OperationType {
  entry('Entrée'),
  exit('Sortie'),
  adjustment('Ajustement');

  final String displayName;
  const OperationType(this.displayName);
}

class StockOperation {
  final String id;
  final String productId;
  final String productName;
  final OperationType type;
  final int quantity;
  final DateTime date;
  final String performedBy;
  final String? notes;

  StockOperation({
    String? id,
    required this.productId,
    required this.productName,
    required this.type,
    required this.quantity,
    required this.performedBy,
    DateTime? date,
    this.notes,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  // Convert an Operation into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'type': type.toString().split('.').last,
      'quantity': quantity,
      'date': date.toIso8601String(),
      'performedBy': performedBy,
      'notes': notes,
    };
  }

  // Create an Operation from a Map
  factory StockOperation.fromMap(Map<String, dynamic> map) {
    return StockOperation(
      id: map['id'],
      productId: map['productId'],
      productName: map['productName'],
      type: OperationType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => OperationType.entry,
      ),
      quantity: map['quantity'],
      date: DateTime.parse(map['date']),
      performedBy: map['performedBy'],
      notes: map['notes'],
    );
  }

  // Get the operation type color
  int get typeColor {
    switch (type) {
      case OperationType.entry:
        return 0xFF4CAF50; // Green
      case OperationType.exit:
        return 0xFFF44336; // Red
      case OperationType.adjustment:
        return 0xFFFFC107; // Amber
    }
  }

  // Get the operation icon
  String get typeIcon {
    switch (type) {
      case OperationType.entry:
        return 'assets/icons/arrow_downward.svg';
      case OperationType.exit:
        return 'assets/icons/arrow_upward.svg';
      case OperationType.adjustment:
        return 'assets/icons/build.svg';
    }
  }
}
