<<<<<<< HEAD
import 'package:booknest_fe/screen/splashscreen.dart';
=======
import 'package:booknest/splash_screen/splash.dart';
>>>>>>> e529e2616875b626c678795e88ebf1fb14b49708
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
=======
        debugShowCheckedModeBanner: false, home: SplashScreen());
>>>>>>> e529e2616875b626c678795e88ebf1fb14b49708
  }
}
