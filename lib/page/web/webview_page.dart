import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/customWidget/CustomAppBar.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({Key key, this.title, this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    print("url:${widget.url}");
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, widget.title),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {

        },
      ),
    );
  }
}

