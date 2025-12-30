

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/dropdownlistingnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
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
      body: Stack(
        children: [
          Center(
        child: Transform.rotate(
          angle: -0.8, // radians me (≈ -30 degree)
          child: Opacity(
            opacity: 0.1, // halka watermark jesa
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
          Padding(
            padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                Center(
                  child: reusableBtn(context, 'Logout', ()async{
                    ref.read(authProvider.notifier).logout();

                    // 2️⃣ Reset bottom nav (Home pe lao)
                    ref.invalidate(bottomNavProvider);

                    // 3️⃣ Clear invoice related providers
                    ref.invalidate(invoiceStreamProvider);
                    ref.invalidate(invoiceFilterProvider);

                    // 4️⃣ Agar dropdown providers hain
                    ref.invalidate(dropdownProvider);

                    // 5️⃣ Storage clear (optional but recommended)
                    await GetStorage('values').erase();
                    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_) => const Login()),
                    (route) => false,);
                  },width: 0.8),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}