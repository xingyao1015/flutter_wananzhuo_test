import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/common/entity/project_tree_entity.dart';
import 'package:flutter_wanandroid_test/common/entity/project_entity.dart';
import 'package:flutter_wanandroid_test/common/net/dio_manager.dart';
import 'package:flutter_wanandroid_test/common/net/project_api.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/customWidget/custom_tabbarview.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, data) {
        if (data.hasData) {
          return TabLayoutDiy(
            datas: data.data.data,
          );
        } else {
          return Center(
            child: Text("没有数据哦"),
          );
        }
      },
      future: ProjectApi.getProjectTree(),
    );
  }
}

class TabLayoutDiy extends StatefulWidget {
  final List<ProjectTreeData> datas;

  const TabLayoutDiy({Key key, this.datas}) : super(key: key);

  @override
  _TabLayoutDiyState createState() => _TabLayoutDiyState();
}

class _TabLayoutDiyState extends State<TabLayoutDiy>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int selectIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: _initTab().length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: _initTab(),
          isScrollable: true,
          indicatorColor: Colors.orange,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black54,
          onTap: (index) {
            setState(() {
              selectIndex = index;
            });
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: CustomTabBarView(
        children: _initTabViews(),
        controller: _tabController,
        keepStateNum: 3,
        index: selectIndex,
      ),
    );
  }

  List<Widget> _initTab() {
    List<Widget> items = widget.datas.map((data) {
      return Container(
        padding: EdgeInsets.only(left: dp(10), right: dp(10)),
        alignment: Alignment.centerLeft,
        height: dp(49),
        child: Text(
          data.name,
          style: TextStyle(
            fontSize: sp(14),
          ),
        ),
      );
    }).toList();
    return items;
  }

  List<Widget> _initTabViews() {
    return widget.datas.map((data) {
      return ProjectChild(
        id: data.id,
      );
    }).toList();
  }
}

class ProjectChild extends StatefulWidget {
  final int id;

  const ProjectChild({Key key, this.id}) : super(key: key);

  @override
  _ProjectChildState createState() => _ProjectChildState();
}

class _ProjectChildState extends State<ProjectChild> {
  int requestPage = 1;
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
        requestPage = 1;
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
        if (requestPage == 1) {
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
      );
    }).toList();

    return ListView(
      children: items,
      shrinkWrap: true,
    );
  }
}
