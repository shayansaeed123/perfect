
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/loginnotifier.dart';
import 'package:project/views/accounts/login.dart';
import 'package:project/views/dashboard/navbar.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {

  bool navigated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    didChangeDependencies();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final authState = ref.read(authProvider);

    if (!authState.isLoading && !navigated) {
      navigated = true;

      Future.delayed(const Duration(seconds: 3), () {
        if (authState.userId!.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const NavBar()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Login()),
          );
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: colorController.whiteColor,
      body: authState.isLoading
            ? const CircularProgressIndicator()
            : Stack(
        fit: StackFit.expand,
        children: [
          /// 🔹 Background Lottie Animation
          // Lottie.asset(
          //   'assets/images/splashanim.json', 
          //   fit: BoxFit.fill,
          //   repeat: true,
          // ),
          /// 🔹 Center Image
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.28,
            ),
          ),
        ],
      ),
    );
  }
}