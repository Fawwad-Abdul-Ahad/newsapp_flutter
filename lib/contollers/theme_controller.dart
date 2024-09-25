import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController{
  RxBool isValue = false.obs;

  changeVal(bool value){
    isValue.value = value;
    if(isValue.value){
      Get.changeTheme(ThemeData.dark());
    }
    else{
      Get.changeTheme(ThemeData.light());
    }
  }
}