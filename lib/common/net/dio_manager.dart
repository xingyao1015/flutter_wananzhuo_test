import 'package:dio/dio.dart';
import 'package:flutter_wanandroid_test/common/utils/sputil.dart';

class DioManager {
  static final Dio _dio = Dio();

  static final String _BASE_URL = "https://www.wanandroid.com/";

  static final DioManager _manager = DioManager();

  static DioManager instance() {
    return _manager;
  }

  Future get(path, {params}) async {
    return _dio.get("$_BASE_URL/$path", queryParameters: params);
  }

  Future post(path, {params}) async {
    return _dio.post("$_BASE_URL/$path", queryParameters: params);
  }
}
