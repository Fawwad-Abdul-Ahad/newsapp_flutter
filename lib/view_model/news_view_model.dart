
import 'package:newsapp/model/headlines_model.dart';
import 'package:newsapp/model/news_category_model.dart';
import 'package:newsapp/services/api_headline.dart';
import 'package:newsapp/services/categories_news_api.dart';

class NewsViewModel{
  final rep = HeadlineAPIService();
  Future<MobiesHeadlinesModel> headlineAPI(String newsChannelName)async{
    final response = await rep.headlineAPI(newsChannelName);
    return response;
  } 
}
class CategoryNewsViewModel{
  final rep = CategoriesNewsClass();
  Future<CategoryNewsAPI> categoriesNewsFunc(String category )async{
    final response = await rep.categoriesNewsFunc(category);
    return response;
  } 
}