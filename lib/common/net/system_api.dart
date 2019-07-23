import 'package:dio/dio.dart';
import 'package:flutter_wanandroid_test/common/entity/news_entity.dart';

import '../entity/system_entity.dart';
import 'dio_manager.dart';

class SystemApi {
  static const _api = {
    SystemApiKey.SYSTEM_TREE: "tree/json", //体系数据
    SystemApiKey.SYSTEM_LIST: "article/list", //体系数据
  };

  static Future<SystemEntity> getSystemTree() async {
    try {
      Response response =
          await DioManager.instance().get(_api[SystemApiKey.SYSTEM_TREE]);
      return SystemEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<NewsEntity> getNewsList(int cid, int page) async {
    try {
      Response response = await DioManager.instance()
          .get("${_api[SystemApiKey.SYSTEM_LIST]}/$page/json?cid=$cid");
      print(response.data);
      return NewsEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }
}

class SystemApiKey {
  static const SYSTEM_TREE = "system_tree";
  static const SYSTEM_LIST = "system_list";
}
