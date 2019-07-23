import '../entity/news_entity.dart';
import 'package:dio/dio.dart';
import 'dio_manager.dart';

class NewsApi {
  static Future<NewsEntity> getNewsList(int page) async {
    try {

      Response response =
          await DioManager.instance().get("${NewsApiKey.ARTICALE_LIST}/$page/json");
      print(response.data);
      return NewsEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }
}

class NewsApiKey {
  static const ARTICALE_LIST = "article/list";//动态首页
}
