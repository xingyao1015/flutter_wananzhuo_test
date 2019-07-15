import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/net/home_api.dart';
import 'package:flutter_wanandroid_test/common/entity/banner_entity.dart';
import 'package:flutter_wanandroid_test/common/entity/project_entity.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import '../web/webview_page.dart';
import 'package:flutter_wanandroid_test/common/utils/navigatorUtils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EasyRefresh(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SwiperDiy(),
          Container(
              color: Colors.orangeAccent,
              alignment: Alignment.centerLeft,
              height: dp(44),
              padding: EdgeInsets.only(left: dp(10), right: dp(10)),
              child: GestureDetector(
                  onTap: () {},
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Icon(
                        Icons.filter_none,
                        color: Colors.white,
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(left: dp(10)),
                        child: Text(
                          "推荐项目",
                          style:
                              TextStyle(color: Colors.white, fontSize: sp(14)),
                        ),
                      )),
                      Text(
                        '更多',
                        style: TextStyle(fontSize: sp(10), color: Colors.white),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      )
                    ],
                  ))),
          RecommendList(),
        ],
      ),
      onRefresh: () {
        setState(() {});
        return null;
      },
    ),
    );
  }
}

class SwiperDiy extends StatefulWidget {
  @override
  _SwiperDiyState createState() => _SwiperDiyState();
}

class _SwiperDiyState extends State<SwiperDiy> {
  List<BannerData> datas = [];

  @override
  void initState() {
    _getBanner();
    super.initState();
  }

  void _getBanner() {
    HomeApi.getBanner().then((entity) {
      setState(() {
        datas.addAll(entity.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _initSwiper();
  }

  Widget _initSwiper() {
    if (datas.isEmpty) {
      return Container(
        width: 0.0,
        height: 0.0,
      );
    }
    return Container(
      height: dp(208),
      child: Swiper(
        itemCount: datas.length,
        autoplay: true,
        itemHeight: dp(208),
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.all(5),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            datas[index].imagePath,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

class RecommendList extends StatefulWidget {
  @override
  _RecommendListState createState() => _RecommendListState();
}

class _RecommendListState extends State<RecommendList> {
  List<ProjectDataData> datas = [];

  @override
  void initState() {
    _getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _initItems();
  }

  void _getProjects() {
    HomeApi.getRecommond().then((entity) {
      setState(() {
        datas.addAll(entity.data.datas);
      });
    });
  }

  Widget _initItems() {
    if (datas.isEmpty) {
      return Container(
        height: dp(200),
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          "没有推荐项目哟",
          style: TextStyle(fontSize: sp(12)),
        ),
      );
    }

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

    return Column(
      children: items,
    );
  }
}
