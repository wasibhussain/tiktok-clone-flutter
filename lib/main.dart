import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/screens/login_screen.dart';
import 'package:tiktok_clone/utils/constants.dart';

import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
  .then(
    (value) {
      Get.put(AuthController());
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tiktok App',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: SignUpScreen(),
    );
  }
}
