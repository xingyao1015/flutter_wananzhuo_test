import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/entity/project_entity.dart';
import 'package:flutter_wanandroid_test/common/event/eventbus.dart';
import 'package:flutter_wanandroid_test/common/net/project_api.dart';
import 'package:flutter_wanandroid_test/common/utils/navigatorUtils.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_wanandroid_test/customWidget/project_item.dart';

class ProjectChild extends StatefulWidget {
  final int id;

  const ProjectChild({Key key, this.id}) : super(key: key);

  @override
  _ProjectChildState createState() => _ProjectChildState();
}

class _ProjectChildState extends State<ProjectChild>
    with AutomaticKeepAliveClientMixin {
  int requestPage = 0;
  List<ProjectDataData> datas = [];
  bool isEmpty = false;
  ScrollController _controller = ScrollController();
  bool isShowToTopBtn = false;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        print(_controller.offset);
        isShowToTopBtn = _controller.offset > 500;
      });
    });

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
      floatingActionButton: isShowToTopBtn
          ? FloatingActionButton(
              onPressed: () {
                _controller.animateTo(0.0,
                    duration: Duration(microseconds: 1000),
                    curve: Curves.linear);
              },
              child: Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            )
          : null,
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
        onTap: () {
          NavigatorUtils.toWeb(data.link, data.title, context);
        },
        child: ProjectItem(
          data: data,
        ),
      );
    }).toList();

    return ListView(
      children: items,
      controller: _controller,
      shrinkWrap: true,
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
