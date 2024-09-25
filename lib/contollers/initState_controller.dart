import 'dart:async';

import 'package:get/get.dart';
import 'package:newsapp/screens/homescreen.dart';
import 'package:newsapp/screens/login_screen.dart';

class GoToNewScreen extends GetxController{

  void onInit(){
    super.onInit();
    Timer(const Duration(seconds: 3), () { 
      Get.to(() => LoginScreen());
    });
  }
}