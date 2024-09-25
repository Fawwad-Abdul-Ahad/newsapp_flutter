import 'package:flutter/material.dart';
// import 'package:newsapp/screb getrens/splash_Screen.dart';
import 'package:get/get.dart';
import 'package:newsapp/screens/splash_Screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
 
}


