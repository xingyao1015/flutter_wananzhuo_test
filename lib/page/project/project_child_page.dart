import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/entity/project_entity.dart';
import 'package:flutter_wanandroid_test/common/net/project_api.dart';
import 'package:flutter_wanandroid_test/common/utils/navigatorUtils.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';


class ProjectChild extends StatefulWidget {
  final int id;

  const ProjectChild({Key key, this.id}) : super(key: key);

  @override
  _ProjectChildState createState() => _ProjectChildState();
}

class _ProjectChildState extends State<ProjectChild> with AutomaticKeepAliveClientMixin{
  int requestPage = 0;
  List<ProjectDataData> datas = [];
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
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
    );
  }

  void _getProjects() {
    ProjectApi.getNewsList(widget.id, requestPage).then((entity) {
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
                            style: TextStyle(fontSize: sp(8), color: Colors.black45),
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

    return ListView(
      children: items,
      shrinkWrap: true,
    );
  }

  @override
  bool get wantKeepAlive => true;

}