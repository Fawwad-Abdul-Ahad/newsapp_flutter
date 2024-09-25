import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:newsapp/screens/homescreen.dart';

class NewsChannelController extends GetxController {
  RxString name = 'bbc-news'.obs; // Observable variable for selected channel
  var selectedItems = filteredList.bbcNews.obs; // Observable for selected menu item

  void onSelected(filteredList item) {
    if (item == filteredList.bbcNews) {
      name.value = 'bbc-news';
    } else if (item == filteredList.aryNews) {
      name.value = 'ary-news';
    } else if (item == filteredList.alJazeera) {
      name.value = 'al-jazeera-english';
    }
    selectedItems.value = item; // Update the selected item
  }
}
