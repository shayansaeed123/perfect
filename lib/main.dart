import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/repo/fontfamily.dart';
import 'package:project/views/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  await GetStorage.init('values'); 
  runApp(
    ProviderScope(child: 
  //   DevicePreview(
  //    enabled: true,
  //    builder: (context) => 
  //   MyApp(), // Wrap your app
  //  ),
    MyApp()
    )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorController.mainColor),
          useMaterial3: true,
          fontFamily: sfProM,
          textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),

        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),

        titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),

        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),

        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(fontSize: 12),
        labelSmall: TextStyle(fontSize: 10),
      ),
        ),
        home: Splash(),
    );
  }
}

