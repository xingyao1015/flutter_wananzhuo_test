import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/common/entity/news_entity.dart';
import 'package:flutter_wanandroid_test/common/utils.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_wanandroid_test/common/net/favorite_api.dart';

class NewsItem extends StatefulWidget {
  final NewsDataData data;

  const NewsItem({Key key, this.data}) : super(key: key);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool isCollect;

  @override
  Widget build(BuildContext context) {
    if (isCollect == null) {
      isCollect = widget.data.collect;
    }

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(dp(10)),
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
                    widget.data.title,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: sp(14), color: Colors.black87),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: dp(10), bottom: dp(10)),
                    child: Text(
                      widget.data.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(fontSize: sp(12), color: Colors.black54),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _getCollectionState(),
                      Container(
                        margin: EdgeInsets.only(left: dp(10), right: dp(10)),
                        child: Text(
                          widget.data.author,
                          style:
                              TextStyle(fontSize: sp(8), color: Colors.black45),
                        ),
                      ),
                      Text(
                        widget.data.niceDate,
                        style:
                            TextStyle(fontSize: sp(8), color: Colors.black45),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            width: dp(70),
            height: dp(70),
            padding: EdgeInsets.all(dp(10)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _getColor(widget.data.superChapterId),
                shape: BoxShape.circle),
            child: Text(
              widget.data.superChapterName,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: sp(12)),
            ),
          )
        ],
      ),
    );
  }

  //判断是否收藏
  Widget _getCollectionState() {

    return IconButton(
      icon: Icon(
        isCollect?Icons.favorite:Icons.favorite_border,
        color: Colors.orange,
      ),
      onPressed: () {
        if(!UserManager.isLogin){
          NavigatorUtils.toLogin(context);
          return;
        }
        if(isCollect){
          FavoriteApi.unCollectInList(widget.data.id).then((data) {
            setState(() {
              if (data['errorCode'] == 0) {
                isCollect = false;
              }
            });
          });
        }else{
          FavoriteApi.collect(widget.data.id).then((data) {
            setState(() {
              if (data['errorCode'] == 0) {
                isCollect = true;
              }
            });
          });
        }
      },
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
