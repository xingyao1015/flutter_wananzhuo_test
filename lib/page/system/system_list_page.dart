import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/entity/system_list_entity.dart';
import 'package:flutter_wanandroid_test/common/net/system_api.dart';
import 'package:flutter_wanandroid_test/common/utils/navigatorUtils.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_wanandroid_test/customWidget/CustomAppBar.dart';

class SystemListPage extends StatefulWidget {
  final String title;
  final int id;

  const SystemListPage({Key key, this.title, this.id}) : super(key: key);

  @override
  _SystemListPageState createState() => _SystemListPageState();
}

class _SystemListPageState extends State<SystemListPage> {
  int requestPage = 0;
  List<SystemListDataData> datas = [];
  bool isEmpty = false;

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
        onTap: (){
          NavigatorUtils.toWeb(data.link, data.title, context);
        },
        child: Container(
          height: dp(100),
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
                        data.title,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: sp(14), color: Colors.black87),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: dp(10), bottom: dp(10)),
                        child: Text(data.desc,
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
                              data.author,
                              style:
                              TextStyle(fontSize: sp(8), color: Colors.black45),
                            ),
                          ),
                          Text(
                            data.niceDate,
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
                    color: _getColor(data.superChapterId),
                    shape: BoxShape.circle),
                child: Text(
                  data.superChapterName,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: sp(12)),
                ),
              )
            ],
          ),
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
