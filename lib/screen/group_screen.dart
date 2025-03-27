import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharely/providers/group_provider.dart';

class GroupScreen extends ConsumerWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('그룹 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              ref.read(groupProvider.notifier).clearGroups();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '참여 중인 그룹',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  groups.isEmpty
                      ? const Center(child: Text('참여 중인 그룹이 없습니다.'))
                      : ListView.builder(
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(groups[index]),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                // TODO: 그룹 상세 화면으로 이동
                              },
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: 그룹 추가 페이지로 이동
                _showAddGroupDialog(context, ref);
              },
              icon: const Icon(Icons.add),
              label: const Text('새 그룹 추가하기'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                _showInviteCodeDialog(context);
              },
              icon: const Icon(Icons.qr_code),
              label: const Text('초대 코드 입력하기'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddGroupDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('새 그룹 추가'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: '그룹 이름을 입력하세요'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  ref.read(groupProvider.notifier).addGroup(controller.text);
                }
                Navigator.of(context).pop();
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }

  void _showInviteCodeDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('초대 코드 입력'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: '초대 코드를 입력하세요'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // TODO: 초대 코드 처리 로직 추가
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
