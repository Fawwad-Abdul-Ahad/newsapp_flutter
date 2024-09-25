import 'package:get/get.dart';
import 'package:newsapp/screens/category_news_screen.dart';
import 'package:newsapp/screens/homescreen.dart';

class CategoryScreenController extends GetxController{
  gotoCategory(){
    Get.to(CategoryNewsScreen());
  }   
}