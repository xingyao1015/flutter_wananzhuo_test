import '../entity/project_entity.dart';
import '../entity/project_tree_entity.dart';
import '../entity/favorite_entity.dart';
import 'package:dio/dio.dart';
import 'dio_manager.dart';

class ProjectApi {
  static Future<ProjectEntity> getNewsList(int cid, int page) async {
    try {
      Response response = await DioManager.instance()
          .get("${ProjectApiKey.PROJECT_LIST}/$page/json?cid=$cid");
      return ProjectEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<ProjectTreeEntity> getProjectTree() async {
    try {
      Response response =
          await DioManager.instance().get(ProjectApiKey.PROJECT_TREE);
      return ProjectTreeEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<FavoriteEntity> getFavoriteList(int page) async {
    try {
      Response response = await DioManager.instance()
          .get("${ProjectApiKey.FAVORITE_LIST}/$page/json");
      print(response.data);
      return FavoriteEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }
}

class ProjectApiKey {
  static const PROJECT_TREE = "project/tree/json";
  static const PROJECT_LIST = "project/list";
  static const FAVORITE_LIST = "lg/collect/list";
}

