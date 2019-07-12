import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/page/search_page.dart';
import 'package:flutter_wanandroid_test/page/user/login_page.dart';
import 'package:flutter_wanandroid_test/page/user/register_page.dart';
import 'package:flutter_wanandroid_test/page/web/webview_page.dart';
import 'package:flutter_wanandroid_test/page/system/system_list_page.dart';

class NavigatorUtils {
  static void toWeb(String url, String title, BuildContext context) {
    Navigator.push(
        context,
        CupertinoPageRoute<void>(
            builder: (ctx) => WebViewPage(
                  title: title,
                  url: url,
                )));
  }

  static void toProjectChild(int id, String title, BuildContext context) {
    Navigator.push(
        context,
        CupertinoPageRoute<void>(
            builder: (ctx) => SystemListPage(
                  title: title,
                  id: id,
                )));
  }

  static void toLogin(BuildContext context) {
    Navigator.push(
        context, CupertinoPageRoute<void>(builder: (ctx) => LoginPage()));
  }

  static void toRegister(BuildContext context) {
    Navigator.push(
        context, CupertinoPageRoute<void>(builder: (ctx) => RegisterPage()));
  }

  static void toSearch(BuildContext context) {
    Navigator.push(
        context, CupertinoPageRoute<void>(builder: (ctx) => SearchPage()));
  }


}
