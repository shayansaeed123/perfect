

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/views/dashboard/addform.dart';
import 'package:project/views/dashboard/home.dart';
import 'package:project/views/dashboard/profile.dart';



// ---------------- Providers ----------------
final bottomNavProvider = StateProvider<int>((ref) => 0);

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  Widget getCurrentScreen(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const AddCars();
      case 2:
        return const Profile();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    return Scaffold(
      body: getCurrentScreen(selectedIndex),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: colorController.mainColor,
        style: TabStyle.react,
        elevation: 10,
        items: [
          TabItem(
            icon: Icon(Icons.home_outlined, color: colorController.textColorLight),
            title: 'Home',
            activeIcon: Icon(Icons.home, color: colorController.textColorLight),
          ),
          TabItem(
            icon: Icon(Icons.add, color: colorController.textColorLight),
            title: 'Add',
            activeIcon: Icon(CupertinoIcons.add_circled, color: colorController.textColorLight),
          ),
          TabItem(
            icon: Icon(Icons.person_outline, color: colorController.textColorLight),
            title: 'Profile',
            activeIcon: Icon(Icons.person, color: colorController.textColorLight),
          ),
        ],
        initialActiveIndex: selectedIndex,
        onTap: (index) {
          ref.read(bottomNavProvider.notifier).state = index;
        },
      ),
    );
  }
}
