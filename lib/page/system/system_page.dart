import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/common/entity/system_entity.dart';
import 'package:flutter_wanandroid_test/common/net/system_api.dart';
import 'package:flutter_wanandroid_test/resources/dimens.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/utils/navigatorUtils.dart';

class SystemPage extends StatefulWidget {
  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, systemtree) {
        if (systemtree.hasData) {
          return _initItem(systemtree.data);
        } else {
          return Container();
        }
      },
      future: SystemApi.getSystemTree(),
    );
  }

  Widget _initItem(SystemEntity entity) {
    if (entity.data == null || entity.data.isEmpty) {
      return Center(
        child: Text("没有数据"),
      );
    }

    List<Widget> items = entity.data.map((data) {
      return SystemTreeItem(
        systemData: data,
      );
    }).toList();

    return EasyRefresh(
      child: ListView(
        children: items,
        shrinkWrap: true,
      ),
      onRefresh: () {
        return SystemApi.getSystemTree().then((system) {
          setState(() {
            _initItem(system);
          });
        });
      },
    );
  }
}

class SystemTreeItem extends StatefulWidget {
  final SystemData systemData;

  const SystemTreeItem({Key key, this.systemData}) : super(key: key);

  @override
  _SystemTreeItemState createState() => _SystemTreeItemState();
}

class _SystemTreeItemState extends State<SystemTreeItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(dp(14)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: dp(10)),
            child: Text(
              widget.systemData.name,
              style: TextStyle(
                  fontSize: sp(14),
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
          ),
          _initItems()
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: new Border(
            bottom: new BorderSide(width: 0.33, color: Colors.black26)),
      ),
    );
  }

  Widget _initItems() {
    List<Widget> items = widget.systemData.children.map((data) {
      return InkWell(
        onTap: () {
          NavigatorUtils.toProjectChild(data.id, data.name, context);
        },
        child: Container(
          padding: EdgeInsets.only(
              top: dp(5), bottom: dp(5), left: dp(10), right: dp(10)),
          margin: EdgeInsets.only(bottom: dp(5), right: dp(5)),
          decoration: BoxDecoration(
              color: _getColor(data.id),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(dp(15)))),
          child: Text(
            data.name,
            style: TextStyle(color: Colors.white, fontSize: sp(12)),
          ),
        ),
      );
    }).toList();
    return Wrap(
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
        return Colors.red;
      case 6:
        return Colors.indigo;
      case 7:
        return Colors.lightGreen;
      case 8:
        return Colors.deepPurpleAccent;
      case 9:
        return Colors.pink;
      default:
        return Colors.teal;
    }
  }
}
