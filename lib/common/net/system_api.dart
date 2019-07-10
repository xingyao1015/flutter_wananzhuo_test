import 'package:flutter_wanandroid_test/common/entity/system_list_entity.dart';

import '../entity/system_entity.dart';
import 'package:dio/dio.dart';
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

  static Future<SystemListEntity> getNewsList(int cid, int page) async {
    try {
      Response response = await DioManager.instance()
          .get("${_api[SystemApiKey.SYSTEM_LIST]}/$page/json?cid=$cid");
      print(response.data);
      return SystemListEntity.fromJson(response.data);
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
