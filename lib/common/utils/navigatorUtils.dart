import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/page/web/webview_page.dart';

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
}
