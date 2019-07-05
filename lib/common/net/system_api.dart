import '../entity/system_entity.dart';
import 'package:dio/dio.dart';
import 'dio_manager.dart';

class SystemApi {
  static const _api = {
    SystemApiKey.SYSTEM_TREE: "tree/json", //体系数据
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
}

class SystemApiKey {
  static const SYSTEM_TREE = "system_tree";
}
