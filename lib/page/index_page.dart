import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'news/news_page.dart';
import 'project/project_page.dart';
import 'system/system_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex = 0;
  var currentPage;

  List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(
        icon: Icon(Icons.account_balance), title: Text('主页')),
    BottomNavigationBarItem(icon: Icon(Icons.add_to_photos), title: Text('项目')),
    BottomNavigationBarItem(icon: Icon(Icons.local_movies), title: Text('动态')),
    BottomNavigationBarItem(icon: Icon(Icons.layers), title: Text('体系'))
  ];

  var pages = [HomePage(), ProjectPage(), NewsPage(), SystemPage()];

  @override
  void initState() {
    super.initState();
    currentPage = pages[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("这是首页"),
    );
  }
}
