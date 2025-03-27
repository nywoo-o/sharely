import 'package:flutter_riverpod/flutter_riverpod.dart';

final borrowableItemsProvider =
    StateNotifierProvider<BorrowableItemsNotifier, List<BorrowableItem>>((ref) {
      return BorrowableItemsNotifier();
    });

class BorrowableItem {
  final String name;
  final String group;
  final bool isInUse;
  final String imageUrl;

  BorrowableItem({
    required this.name,
    required this.group,
    required this.isInUse,
    required this.imageUrl,
  });
}

class BorrowableItemsNotifier extends StateNotifier<List<BorrowableItem>> {
  final List<BorrowableItem> _allItems = [
    BorrowableItem(
      name: '자전거',
      group: '가족',
      isInUse: false,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    BorrowableItem(name: '노트북', group: '친구', isInUse: true, imageUrl: ''),
    BorrowableItem(name: '카메라', group: '가족', isInUse: false, imageUrl: ''),
  ];

  BorrowableItemsNotifier() : super([]) {
    state = _allItems;
  }

  void filterByGroup(String group) {
    if (group == '전체') {
      state = [..._allItems]; // 모든 항목 표시
    } else {
      state = _allItems.where((item) => item.group == group).toList();
    }
  }
}
