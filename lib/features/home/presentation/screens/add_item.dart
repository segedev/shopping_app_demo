import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_demo/features/home/data/models/shopping_item_model.dart';
import 'package:shopping_app_demo/features/home/presentation/providers/shopping_provider.dart';

class AddItemScreen extends StatefulWidget {
  final ShoppingItem? item;

  const AddItemScreen({super.key, this.item});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _quantityController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.item != null;
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.item?.description ?? '',
    );
    _quantityController = TextEditingController(
      text: widget.item?.quantity.toString() ?? '1',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate()) {
      final shoppingProvider = context.read<ShoppingProvider>();

      final item = ShoppingItem(
        id: widget.item?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        quantity: int.parse(_quantityController.text),
        createdAt: widget.item?.createdAt ?? DateTime.now(),
        isCompleted: widget.item?.isCompleted ?? false,
      );

      if (_isEditing) {
        await shoppingProvider.updateItem(item);
      } else {
        await shoppingProvider.addItem(item);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing ? 'Item updated' : 'Item added'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit Item' : 'Add Item')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                prefixIcon: Icon(Icons.shopping_bag_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter item name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                prefixIcon: Icon(Icons.description_outlined),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter quantity';
                }
                final quantity = int.tryParse(value);
                if (quantity == null || quantity <= 0) {
                  return 'Please enter a valid quantity';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveItem,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  _isEditing ? 'Update Item' : 'Add Item',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
