import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/news_category_model.dart';

class CategoriesNewsClass {
  Future<CategoryNewsAPI> categoriesNewsFunc(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=79f99ca4a7ae450d842d5d946496d8e2';

    var response = await http.get(Uri.parse(url));
    
    // Check status code
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return CategoryNewsAPI.fromJson(body);
    }
    
    throw Exception("Error fetching data");
  }
}

