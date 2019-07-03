import 'package:dio/dio.dart';
import 'package:flutter_wanandroid_test/common/utils/sputil.dart';

class DioManager {
  static final Dio _dio = Dio();

  static final String _BASE_URL = "https://test.online.qsyuwen.cn/api";

  static final DioManager _manager = DioManager();

  static DioManager instance() {
    _dio.options.headers = {
      "XTHK-ONLINE-VERSION": "2.1.2",
      "APP-NAME": "online_edu_user_app",
      "Authorization": SpUtil.get(SpUtil.KEY_TOKEN)
    };
    return _manager;
  }

  Future get(path, {params}) async {
    return _dio.get("$_BASE_URL/$path", queryParameters: params);
  }

  Future post(path, {params}) async {
    return _dio.post("$_BASE_URL/$path", queryParameters: params);
  }
}
