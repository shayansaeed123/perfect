

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/loginnotifier.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/views/accounts/login.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: colorController.whiteColor,
      body: Padding(
        padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: reusableBtn(context, 'Logout', (){
                ref.read(authProvider.notifier).logout();
                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_) => const Login()),
                (route) => false,);
              }),
            )
          ],
        ),
      ),
    );
  }
}