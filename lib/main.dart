import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/views/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('values'); // 👈 ye zaroori hai
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorController.mainColor),
          useMaterial3: true,
        ),
        home: Splash(),
      ),
    );
  }
}

