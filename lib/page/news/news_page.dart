import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/event/eventbus.dart';
import 'package:flutter_wanandroid_test/common/net/news_api.dart';
import 'package:flutter_wanandroid_test/common/entity/news_entity.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_wanandroid_test/common/utils/navigatorUtils.dart';
import 'package:flutter_wanandroid_test/customWidget/news_item.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int requestPage = 0;
  bool isEmpty = false;
  List<NewsDataData> newses = [];

  @override
  void initState() {
    bus.on(Event.LOGIN, (isLogin) {
      if (isLogin) {
        requestPage = 0;
        _getList();
      }
    });

    bus.on(Event.LOGOUT, (idfd) {
      requestPage = 0;
      _getList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: _initItems(),
      firstRefresh: true,
      onRefresh: () {
        requestPage = 0;
        _getList();
        return null;
      },
      loadMore: () {
        requestPage++;
        _getList();
        return null;
      },
    );
  }

  void _getList() {
    NewsApi.getNewsList(requestPage).then((data) {
      setState(() {
        var empty = data.data == null ||
            data.data.datas == null ||
            data.data.datas.isEmpty;
        if (requestPage == 0) {
          newses.clear();
          isEmpty = empty;
        }
        if (!empty) {
          newses.addAll(data.data.datas);
        }
        requestPage++;
      });
    });
  }

  Widget _initItems() {
    List<Widget> items = newses.map((news) {
      return InkWell(
        onTap: () {
          NavigatorUtils.toWeb(news.link, news.title, context);
        },
        child: NewsItem(
          data: news,
        ),
      );
    }).toList();

    return ListView(
      shrinkWrap: true,
      children: items,
    );
  }

  Color _getColor(int superChapterId) {
    switch (superChapterId % 10) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.cyan;
      case 3:
        return Colors.deepPurple;
      case 4:
        return Colors.green;
      case 5:
        return Colors.deepOrange;
      case 6:
        return Colors.indigo;
      case 7:
        return Colors.lightGreen;
      case 8:
        return Colors.deepPurpleAccent;
      case 9:
        return Colors.greenAccent;
      default:
        return Colors.lime;
    }
  }
}
