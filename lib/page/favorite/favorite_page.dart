import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/entity/favorite_entity.dart';
import 'package:flutter_wanandroid_test/common/net/project_api.dart';
import 'package:flutter_wanandroid_test/common/utils.dart';
import 'package:flutter_wanandroid_test/customWidget/CustomAppBar.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int requestPage = 0;
  List<FavoriteDataData> datas = [];
  bool isEmpty = false;

  @override
  void initState() {
    _getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, "收藏夹"),
      body: _initBody(),
    );
  }



  Widget _initBody() {
    List<Widget> items = datas.map((data) {
      return InkWell(
        onTap: () {
          NavigatorUtils.toWeb(data.link, data.title, context);
        },
        child: Container(
          width: double.infinity,
          height: dp(170),
          padding: EdgeInsets.all(dp(10)),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: new BorderSide(width: 0.33, color: Colors.black26))),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                  child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    style: TextStyle(fontSize: sp(14), color: Colors.black87),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: dp(10), right: dp(10)),
                    child: Text(
                      data.desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: sp(12),
                        color: Colors.black54,
                      ),
                    ),
                  )),
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
                        style:
                            TextStyle(fontSize: sp(8), color: Colors.black45),
                      )
                    ],
                  )
                ],
              )),
              Image.network(
                data.envelopePic,
                fit: BoxFit.cover,
                width: dp(80),
                height: dp(150),
              )
            ],
          ),
        ),
      );
    }).toList();

    if(items.isEmpty){
      return Center(child: Text("您还没有收藏哟",),);
    }

    return EasyRefresh(
      child: ListView(
        shrinkWrap: true,
        children: items,
      ),
      loadMore: () {
        requestPage++;
        _getFavorite();
        return null;
      },
      onRefresh: () {
        requestPage = 0;
        _getFavorite();
        return null;
      },
      firstRefresh: true,
    );
  }

  void _getFavorite() {
    ProjectApi.getFavoriteList(requestPage).then((entity) {
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
}
