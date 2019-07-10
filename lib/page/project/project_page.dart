import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/common/entity/project_tree_entity.dart';
import 'package:flutter_wanandroid_test/common/entity/project_entity.dart';
import 'package:flutter_wanandroid_test/common/net/dio_manager.dart';
import 'package:flutter_wanandroid_test/common/net/project_api.dart';
import 'package:flutter_wanandroid_test/common/utils/navigatorUtils.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'project_child_page.dart';

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
      body: TabBarView(
        children: _initTabViews(),
        controller: _tabController,
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

