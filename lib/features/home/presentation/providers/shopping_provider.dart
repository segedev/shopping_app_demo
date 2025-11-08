import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_app_demo/features/home/data/models/shopping_item_model.dart';

class ShoppingProvider extends ChangeNotifier {
  late Box<ShoppingItem> _shoppingBox;
  List<ShoppingItem> _items = [];

  ShoppingProvider() {
    _initializeBox();
  }

  List<ShoppingItem> get items => _items;

  Future<void> _initializeBox() async {
    _shoppingBox = Hive.box<ShoppingItem>('shopping_items');
    _loadItems();
  }

  void _loadItems() {
    _items = _shoppingBox.values.toList();
    _items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }

  Future<void> addItem(ShoppingItem item) async {
    await _shoppingBox.put(item.id, item);
    _loadItems();
  }

  Future<void> updateItem(ShoppingItem item) async {
    await _shoppingBox.put(item.id, item);
    _loadItems();
  }

  Future<void> deleteItem(String id) async {
    await _shoppingBox.delete(id);
    _loadItems();
  }

  Future<void> toggleComplete(String id) async {
    final item = _shoppingBox.get(id);
    if (item != null) {
      final updatedItem = item.copyWith(isCompleted: !item.isCompleted);
      await _shoppingBox.put(id, updatedItem);
      _loadItems();
    }
  }

  ShoppingItem? getItemById(String id) {
    return _shoppingBox.get(id);
  }
}
