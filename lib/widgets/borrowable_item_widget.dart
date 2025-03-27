import 'package:flutter/material.dart';
import 'package:sharely/providers/borrowable_provider.dart';

class BorrowableItemWidget extends StatelessWidget {
  final BorrowableItem item;

  const BorrowableItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.imageUrl.isEmpty
              ? Container(
                width: double.infinity,
                height: 120,
                color: Colors.grey[200],

                child: const Icon(Icons.image, size: 40, color: Colors.grey),
              )
              : Image.network(
                width: double.infinity,
                height: 120,
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 120,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    ),
                  );
                },
              ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '그룹: ${item.group}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  item.isInUse ? '사용 중' : '사용 가능',
                  style: TextStyle(
                    fontSize: 14,
                    color: item.isInUse ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
