import 'package:dio/dio.dart';

import 'dio_manager.dart';

class UserApi {

  static Future login(String userName, String password) async {
    try {
      var data = {'username': userName, 'password': password};

      Response response =
          await DioManager.instance().post(UserApiKey.API_LOGIN, params: data);

      response.headers.forEach((String name, List<String> values) {
        if ('set-cookie' == name) {
          DioManager.instance().setCookie(values.toString());
        }
      });

      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future register(
      String userName, String password, String repassword) async {
    try {
      var data = {
        'username': userName,
        'password': password,
        'repassword': repassword
      };

      Response response = await DioManager.instance()
          .post(UserApiKey.API_REGISTER, params: data);
      if (response.data['errorCode'] == 0) {
        return login(userName, password);
      } else {
        return response.data;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future logout() async {
    try {
      Response response =
          await DioManager.instance().get(UserApiKey.API_LOGOUT);
      DioManager.instance().removeCookie();
    } catch (e) {
      print(e);
    }
  }
}

class UserApiKey {
  static final API_LOGIN = 'user/login';
  static final API_REGISTER = 'user/register';
  static final API_LOGOUT = 'user/logout/json';
}
