import 'package:dio/dio.dart';

class DioManager {
  static Dio _dio;

  static final String _BASE_URL = "https://www.wanandroid.com/";

  static DioManager _manager;

  DioManager._internal();

  static DioManager instance() {
    if (_manager == null) {
      _manager = DioManager._internal();
      _dio = Dio();
    }
    return _manager;
  }

  ///添加cookie
  ///[cookies] 需要添加到请求头的cookies
  void setCookie(String cookies) {
    Map<String, dynamic> _headers = Map();
    _headers["Cookie"] = cookies;
    _dio.options.headers.addAll(_headers);
  }

  ///删除cookie
  void removeCookie() {
    _dio.options.headers.remove("Cookie");
  }

  Future get(path, {params}) async {
    return _dio.get("$_BASE_URL/$path", queryParameters: params);
  }

  Future post(path, {params}) async {
    return _dio.post("$_BASE_URL/$path", queryParameters: params);
  }
}
