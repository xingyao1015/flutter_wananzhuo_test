import '../entity/project_entity.dart';
import '../entity/project_tree_entity.dart';
import 'package:dio/dio.dart';
import 'dio_manager.dart';

class ProjectApi {
  static const _api = {
    ProjectApiKey.PROJECT_TREE: "project/tree/json", //项目分类
    ProjectApiKey.PROJECT_LIST: "project/list", //项目列表
  };

  static Future<ProjectEntity> getNewsList(int cid, int page) async {
    try {
      Response response = await DioManager()
          .get("${_api[ProjectApiKey.PROJECT_LIST]}/$page/json?cid=$cid");
      return ProjectEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<ProjectTreeEntity> getProjectTree() async {
    try {
      Response response =
          await DioManager().get(_api[ProjectApiKey.PROJECT_TREE]);
      return ProjectTreeEntity.fromJson(response.data);
    } catch (e) {
      print(e);
      return e;
    }
  }
}

class ProjectApiKey {
  static const PROJECT_TREE = "project_tree";
  static const PROJECT_LIST = "project_list";
}
