import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CategoryChangeController extends GetxController{
  RxBool isTap = true.obs;
  RxString categoryName = "General".obs;
  List<String> categoryList = ['General', 'Sports', 'Business', 'Health', 'Entertainment', 'Wealth', 'Technology'];

  changeCategory(int index){
    categoryName.value = categoryList[index];
  }
}