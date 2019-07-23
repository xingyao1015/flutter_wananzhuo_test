import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/entity/news_entity.dart';
import 'package:flutter_wanandroid_test/common/event/eventbus.dart';
import 'package:flutter_wanandroid_test/common/net/system_api.dart';
import 'package:flutter_wanandroid_test/common/utils/navigatorUtils.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_wanandroid_test/customWidget/CustomAppBar.dart';
import 'package:flutter_wanandroid_test/customWidget/news_item.dart';

class SystemListPage extends StatefulWidget {
  final String title;
  final int id;

  const SystemListPage({Key key, this.title, this.id}) : super(key: key);

  @override
  _SystemListPageState createState() => _SystemListPageState();
}

class _SystemListPageState extends State<SystemListPage> {
  int requestPage = 0;
  List<NewsDataData> datas = [];
  bool isEmpty = false;

  @override
  void initState() {
    bus.on(Event.LOGIN, (isLogin) {
      if (isLogin) {
        requestPage = 0;
        _getProjects();
      }
    });

    bus.on(Event.LOGOUT, (idfd) {
      requestPage = 0;
      _getProjects();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, widget.title),
      body: EasyRefresh(
        child: _initItem(),
        loadMore: () {
          requestPage++;
          _getProjects();
          return null;
        },
        onRefresh: () {
          requestPage = 0;
          _getProjects();
          return null;
        },
        firstRefresh: true,
      ),
    );
  }

  void _getProjects() {
    SystemApi.getNewsList(widget.id, requestPage).then((entity) {
      setState(() {
        var empty = entity.data == null ||
            entity.data.datas == null ||
            entity.data.datas.isEmpty;
        if (requestPage == 0) {
          datas.clear();
          isEmpty = empty;
        }
        if (!empty) {
          datas.addAll(entity.data.datas);
        }
        requestPage++;
      });
    });
  }

  Widget _initItem() {
    List<Widget> items = datas.map((data) {
      return InkWell(
        onTap: () {
          NavigatorUtils.toWeb(data.link, data.title, context);
        },
        child: NewsItem(
          data: data,
        ),
      );
    }).toList();

    if (datas.isEmpty) {
      return Container(
        height: dp(500),
        child: Center(
          child: Text("暂无相关数据哦~~"),
        ),
      );
    } else {
      return ListView(
        children: items,
        shrinkWrap: true,
      );
    }
  }
}
