import 'package:dio/dio.dart';
import 'dio_manager.dart';

class FavoriteApi {
  static Future collect(int id) async {
    try {
      Response response =
          await DioManager.instance().post("${FavoriteApiKey.COLLECT}/$id/json");
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future unCollectInList(int id) async {
    try {
      Response response = await DioManager.instance()
          .post("${FavoriteApiKey.UN_COLLECT_IN_LIST}/$id/json");
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future unCollectInFavorite(int id, int originId) async {
    try {
      var data = {'originId': originId};
      Response response = await DioManager.instance()
          .post("${FavoriteApiKey.UN_COLLECT_IN_FAVORITE}/$id/json", params: data);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return e;
    }
  }
}

class FavoriteApiKey {
  static const COLLECT = "lg/collect"; //收藏站内文章
  static const UN_COLLECT_IN_LIST = "lg/uncollect_originId"; //在列表页取消收藏文章
  static const UN_COLLECT_IN_FAVORITE = "lg/uncollect"; //在收藏夹取消收藏文章
}
