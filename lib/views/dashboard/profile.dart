

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/views/accounts/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: colorController.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: reusableBtn(context, 'Logout', (){
              MySharedPrefrence().logout();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
            }),
          )
        ],
      ),
    );
  }
}