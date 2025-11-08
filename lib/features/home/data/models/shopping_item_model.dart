import 'package:hive/hive.dart';

part 'shopping_item_model.g.dart';

@HiveType(typeId: 0)
class ShoppingItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  bool isCompleted;

  ShoppingItem({
    required this.id,
    required this.name,
    this.description,
    this.quantity = 1,
    required this.createdAt,
    this.isCompleted = false,
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    String? description,
    int? quantity,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
