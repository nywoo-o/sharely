import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharely/providers/borrowable_provider.dart';
import 'package:sharely/widgets/borrowable_item_widget.dart';

final selectedGroupProvider = StateProvider<String>((ref) => '전체');

class BorrowableScreen extends ConsumerWidget {
  const BorrowableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(borrowableItemsProvider);
    final selectedGroup = ref.watch(selectedGroupProvider); // 현재 선택된 그룹

    final groups = ['전체', '가족', '친구']; // 필터 그룹 목록

    return Scaffold(
      appBar: AppBar(title: const Text('빌릴 수 있는 물건')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedGroup,
              onChanged: (value) {
                if (value != null) {
                  ref.read(selectedGroupProvider.notifier).state = value;

                  ref
                      .read(borrowableItemsProvider.notifier)
                      .filterByGroup(value);
                }
              },
              items:
                  groups.map((group) {
                    return DropdownMenuItem(value: group, child: Text(group));
                  }).toList(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return BorrowableItemWidget(item: items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
