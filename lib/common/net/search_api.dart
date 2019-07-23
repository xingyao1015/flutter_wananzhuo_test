import 'package:flutter_wanandroid_test/common/entity/news_entity.dart';

import '../entity/custom_url_entity.dart';
import '../entity/hot_key_entity.dart';
import 'package:dio/dio.dart';
import 'dio_manager.dart';

class SearchApi {
  static Future<CustomUrlEntity> getCustomUrl() async {
    try {
      Response response =
      await DioManager.instance().get(SearchApiKey.API_FRIEND);
      print(response.data);
      return CustomUrlEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<HotKeyEntity> getHotKey() async {
    try {
      Response response =
      await DioManager.instance().get(SearchApiKey.API_HOTKEY);
      print(response.data);
      return HotKeyEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<NewsEntity> search(String words, int page) async {
    try {
      var data = {'k': words};
      Response response = await DioManager.instance()
          .post("${SearchApiKey.API_SEARCH}/$page/json", params: data);
      print(response);
      return NewsEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }
}

class SearchApiKey {
  static final API_FRIEND = 'friend/json'; //常用网站
  static final API_HOTKEY = 'hotkey/json'; //搜索热词
  static final API_SEARCH = 'article/query'; //搜索
}
