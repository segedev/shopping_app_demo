import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_demo/features/home/data/models/shopping_item_model.dart';
import 'package:shopping_app_demo/features/home/presentation/providers/shopping_provider.dart';
import 'package:shopping_app_demo/features/home/presentation/screens/add_item.dart';

class ShoppingItemCard extends StatelessWidget {
  final ShoppingItem item;

  const ShoppingItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final shoppingProvider = context.read<ShoppingProvider>();

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 32),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Item'),
              content: Text('Are you sure you want to delete "${item.name}"?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        shoppingProvider.deleteItem(item.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} deleted'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                shoppingProvider.addItem(item);
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddItemScreen(item: item),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Checkbox(
                  value: item.isCompleted,
                  onChanged: (value) {
                    shoppingProvider.toggleComplete(item.id);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              decoration: item.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (item.description != null &&
                          item.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          item.description!,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.grey[600],
                                decoration: item.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.numbers,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Qty: ${item.quantity}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
