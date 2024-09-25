import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/headlines_model.dart';

class HeadlineAPIService {
  
  Future<MobiesHeadlinesModel> headlineAPI(String newsChannelName)async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=$newsChannelName&apiKey=79f99ca4a7ae450d842d5d946496d8e2';
    final response =await  http.get(Uri.parse(url));
    print(response.statusCode.toString());
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      // print(body);
      return MobiesHeadlinesModel.fromJson(body);
    }
    throw ("Error");
  }
}
