import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharely/screen/borrowable_screen.dart';
import 'package:sharely/screen/borrowing_screen.dart';
import 'package:sharely/screen/group_screen.dart';
import 'package:sharely/screen/settings_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final navigationProvider = StateProvider<int>((ref) => 0);

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final screens = [
    const BorrowingScreen(),
    const BorrowableScreen(),
    const GroupScreen(),
    const SettingsScreen(),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    return MaterialApp(
      title: 'Shared Timetable App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => ref.read(navigationProvider.notifier).state = index,
          selectedItemColor: Colors.blue, // 선택된 아이템 색상
          unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.now_widgets),
              label: 'In Use',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'All'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
