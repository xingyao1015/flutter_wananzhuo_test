import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';

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
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("玩安卓"),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context){
          return IconButton(icon: Icon(Icons.pages), onPressed: (){
            Scaffold.of(context).openDrawer();
          });
        }),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
      ),
      drawer: Drawer(
        child: LeftDrawer(),
      ),
    );
  }
}


class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: dp(100),
      color: Colors.white,
      height: double.infinity,
      child: Text("再来一次"),
    );
  }
}

