import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';

import 'home/home_page.dart';
import 'news/news_page.dart';
import 'project/project_page.dart';
import 'system/system_page.dart';

import 'package:flutter_wanandroid_test/common/event/eventbus.dart';

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
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(Icons.pages),
              onPressed: () {
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

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  bool isLogin = false;
  String username = "点击登录";

  @override
  void initState() {
    bus.on(Event.LOGIN, (arg) {
      setState(() {
        isLogin = true;
        username = arg.username;
      });
    });
    bus.on(Event.LOGOUT, (arg) {
      setState(() {
        isLogin = false;
        username = "点击登录";
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    bus.off(Event.LOGIN);
    bus.off(Event.LOGOUT);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: dp(20)),
              child: ClipOval(
                child: Image.asset(
                  "image/protrait.png",
                  width: dp(80),
                  height: dp(80),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: dp(10)),
                child: Text(
                  username,
                  style: TextStyle(color: Colors.black45, fontSize: sp(16)),
                ),
              ),
            ),
            Container(
              height: dp(30),
              width: double.infinity,
              color: Colors.orangeAccent[100],
              alignment: Alignment.center,
              child: Text(
                "玩安卓",
                style: TextStyle(color: Colors.white, fontSize: sp(12)),
              ),
            ),
            _initItem("收藏", Icons.camera),
            _initItem("TODO", Icons.description),
            _initItem("注销", Icons.power_settings_new),
          ],
        ));
  }

  Widget _initItem(String title, IconData icon) {
    return InkWell(
      onTap: () {
        _clickEvent(title);
      },
      child: Container(
        margin: EdgeInsets.all(dp(15)),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black38,
            ),
            Container(
              margin: EdgeInsets.only(left: dp(20)),
              child: Text(
                title,
                style: TextStyle(fontSize: sp(12), color: Colors.black38),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _clickEvent(String title) {
    if (isLogin) {
      switch (title) {
        case '收藏':
          print("收藏");
          break;
        case 'TODO':
          print("TODO");
          break;
        case '注销':
          print('注销');
          break;
      }
    } else {
      print("登录");
    }
  }
}
