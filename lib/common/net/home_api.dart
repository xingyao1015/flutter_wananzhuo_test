import 'package:dio/dio.dart';

import 'dio_manager.dart';
import '../entity/banner_entity.dart';
import '../entity/project_entity.dart';


class HomeApi{

  static const _homeApi = {
    HomeApiKey.BANNER: "banner/json", //首页banner
    HomeApiKey.RECOMMOND: "project/list/0/json?cid=294" //首页推荐项目
  };

  static Future<BannerEntity> getBanner() async {
    try {
      Response response = await DioManager.instance().get(_homeApi[HomeApiKey.BANNER]);
      print(response.data);
      return BannerEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<ProjectEntity> getRecommond() async {
    try {
      Response response = await DioManager.instance().get(_homeApi[HomeApiKey.RECOMMOND]);
      print(response.data);
      return ProjectEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }

}

class HomeApiKey {
  static const BANNER = "banner";
  static const RECOMMOND = "recommond";
}
