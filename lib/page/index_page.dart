import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';

import 'home/home_page.dart';
import 'news/news_page.dart';
import 'project/project_page.dart';
import 'system/system_page.dart';

import 'package:flutter_wanandroid_test/common/event/eventbus.dart';
import 'package:flutter_wanandroid_test/common/net/user_api.dart';
import 'package:flutter_wanandroid_test/common/utils.dart';
import 'package:rxdart/rxdart.dart';

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
        title: Text(
          "玩安卓",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                Icons.pages,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                NavigatorUtils.toSearch(context);
              })
        ],
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
  String username = "点击登录";

  @override
  void initState() {
    if (UserManager.isLogin) {
      SpUtil.get(SpUtil.KEY_USERNAME).then((data) {
        setState(() {
          username = data;
        });
      });
    }

    SpUtil.get(SpUtil.KEY_USERNAME).then((name) {
      if (name != null) {
        SpUtil.getString(SpUtil.KEY_PASSWORD).then((password) {
          if (password != null) {
            _login(name, password);
          } else {
            setState(() {
              username = '点击登录';
            });
          }
        });
      }
    });

    bus.on(Event.LOGIN, (arg) {
      setState(() {
        username = arg['data']['nickname'];
      });
    });
    bus.on(Event.LOGOUT, (arg) {
      setState(() {
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
              onTap: (){
                if(!UserManager.isLogin){
                  NavigatorUtils.toLogin(context);
                }
              },
              child: Container(
                padding: EdgeInsets.only(top: dp(10), bottom: dp(10)),
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
            UserManager.isLogin
                ? _initItem("注销", Icons.power_settings_new)
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
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
    if (UserManager.isLogin) {
      switch (title) {
        case '收藏':
          print("收藏");
          NavigatorUtils.toFavorite(context);
          break;
        case 'TODO':
          SnakeUtil.show(context, "TODO");
          break;
        case '注销':
          _showLogoutDialog();
          break;
      }
    } else {
      NavigatorUtils.toLogin(context);
      print("登录");
    }
  }

  void _showLogoutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: dp(280),
              height: dp(120),
              padding: EdgeInsets.all(dp(20)),
              child: Column(
                children: <Widget>[
                  Text(
                    "确认退出登录吗？",
                    style: TextStyle(fontSize: sp(12), color: Colors.black87),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: dp(40)),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: dp(80),
                              height: dp(20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(dp(2))),
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: Colors.orange, width: 1)),
                              child: Text(
                                "取消",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: sp(14)),
                              )),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            UserApi.logout().then((data) {
                              Navigator.pop(context);
                              SpUtil.remove(SpUtil.KEY_PASSWORD);
                              bus.emit(Event.LOGOUT, false);
                            });
                          },
                          child: Container(
                              width: dp(80),
                              height: dp(20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(dp(2))),
                                color: Colors.orange,
                                shape: BoxShape.rectangle,
                              ),
                              child: Text(
                                "确定",
                                style: TextStyle(
                                    color: Colors.white, fontSize: sp(14)),
                              )),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(dp(4)))),
            ),
          );
        });
  }

  void _login(String username, String password) {
    UserApi.login(username, password).then((data) {
      SpUtil.add(SpUtil.KEY_USERNAME, username);
      SpUtil.add(SpUtil.KEY_PASSWORD, password);
      bus.emit(Event.LOGIN, data);
    });
  }
}
