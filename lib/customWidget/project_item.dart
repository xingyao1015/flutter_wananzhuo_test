import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/common/entity/project_entity.dart';
import 'package:flutter_wanandroid_test/common/net/favorite_api.dart';
import 'package:flutter_wanandroid_test/common/utils.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';

class ProjectItem extends StatefulWidget {
  final ProjectDataData data;

  const ProjectItem({Key key, this.data}) : super(key: key);

  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool isCollect;

  @override
  Widget build(BuildContext context) {
    if (isCollect == null) {
      isCollect = widget.data.collect;
    }
    return Container(
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
                widget.data.title,
                style: TextStyle(fontSize: sp(14), color: Colors.black87),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: dp(10), right: dp(10)),
                child: Text(
                  widget.data.desc,
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
                  _getCollectionState(),
                  Container(
                    margin: EdgeInsets.only(left: dp(10), right: dp(10)),
                    child: Text(
                      widget.data.author,
                      style: TextStyle(fontSize: sp(8), color: Colors.black45),
                    ),
                  ),
                  Text(
                    widget.data.niceDate,
                    style: TextStyle(fontSize: sp(8), color: Colors.black45),
                  )
                ],
              )
            ],
          )),
          Image.network(
            widget.data.envelopePic,
            fit: BoxFit.cover,
            width: dp(80),
            height: dp(150),
          )
        ],
      ),
    );
  }

  //判断是否收藏
  Widget _getCollectionState() {
    return IconButton(
      icon: Icon(
        isCollect ? Icons.favorite : Icons.favorite_border,
        color: Colors.orange,
      ),
      onPressed: () {
        if (!UserManager.isLogin) {
          NavigatorUtils.toLogin(context);
          return;
        }
        if (isCollect) {
          FavoriteApi.unCollectInList(widget.data.id).then((data) {
            setState(() {
              if (data['errorCode'] == 0) {
                isCollect = false;
              }
            });
          });
        } else {
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
}
