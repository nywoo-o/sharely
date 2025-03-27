import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupProvider = StateNotifierProvider<GroupNotifier, List<String>>((ref) {
  return GroupNotifier();
});

class GroupNotifier extends StateNotifier<List<String>> {
  GroupNotifier() : super([]);

  void addGroup(String groupName) {
    state = [...state, groupName];
  }

  void clearGroups() {
    state = [];
  }
}
