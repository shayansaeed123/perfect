

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/loginnotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/views/dashboard/addCars.dart';
import 'package:project/views/dashboard/home.dart';
import 'package:project/views/dashboard/profile.dart';





class NavBar extends ConsumerStatefulWidget {
  const NavBar({super.key});

  @override
  ConsumerState<NavBar> createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {

   @override
  void initState() {
    super.initState();
    // 👇 Reset tab on open
    ref.read(bottomNavProvider.notifier).state = 0;
  } 
  
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
  Widget build(BuildContext context,) {
    final selectedIndex = ref.watch(bottomNavProvider);

    return Scaffold(
      body: getCurrentScreen(selectedIndex),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: colorController.mainColor,
        gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          
                          colorController.mainColor,
                          colorController.textColorLight,
                        ],
                      ),
        style: TabStyle.react,
        elevation: 10,
        items: [
          TabItem(
            icon: Icon(Icons.home_outlined, color: colorController.textColorLight),
            title: 'Home',
            activeIcon: Icon(Icons.home, color: colorController.whiteColor),
          ),
          TabItem(
            icon: Icon(Icons.add, color: colorController.textColorLight),
            title: 'Add',
            activeIcon: Icon(CupertinoIcons.add_circled, color: colorController.whiteColor),
          ),
          TabItem(
            icon: Icon(Icons.person_outline, color: colorController.textColorLight),
            title: 'Profile',
            activeIcon: Icon(Icons.person, color: colorController.whiteColor),
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