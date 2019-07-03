import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/net/news_api.dart';
import 'package:flutter_wanandroid_test/common/entity/news_entity.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int requestPage = 1;
  bool isEmpty = false;
  List<NewsDataData> newses = [];

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: _initItems(),
      firstRefresh: true,
      onRefresh: () {
        requestPage = 1;
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
        if (requestPage == 1) {
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
      return Container(
        height: dp(110),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left:dp(10),right: dp(10)),
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                bottom: new BorderSide(width: 0.33, color: Colors.black26))),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: dp(10)),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      news.title,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: sp(14), color: Colors.black87),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: dp(10), bottom: dp(10)),
                      child: Text(news.desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: sp(12),
                            color: Colors.black54
                        ),),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.favorite_border),
                        Container(
                          margin: EdgeInsets.only(left: dp(10), right: dp(10)),
                          child: Text(
                            news.author,
                            style:
                            TextStyle(fontSize: sp(8), color: Colors.black45),
                          ),
                        ),
                        Text(
                          news.niceDate,
                          style: TextStyle(fontSize: sp(8), color: Colors.black45),
                        )
                      ],
                    )
                  ],
                ),),
            ),
            Container(
              width: dp(70),
              height: dp(70),
              padding: EdgeInsets.all(dp(10)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _getColor(news.superChapterId),
                  shape: BoxShape.circle),
              child: Text(
                news.superChapterName,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: sp(12)),
              ),
            )
          ],
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
