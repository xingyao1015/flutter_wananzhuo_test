import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/net/home_api.dart';
import 'package:flutter_wanandroid_test/common/entity/banner_entity.dart';
import 'package:flutter_wanandroid_test/common/entity/recommond_entity.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter/cupertino.dart';

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
          RecommendList(),
        ],
      ),
      onRefresh: () {
        setState(() {});
        return null;
      },
    ));
  }
}

class SwiperDiy extends StatefulWidget {
  @override
  _SwiperDiyState createState() => _SwiperDiyState();
}

class _SwiperDiyState extends State<SwiperDiy> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, banner) {
        if (banner.hasData) {
          return _initSwiper(banner.data);
        } else {
          return Center(
            child: Text("没有数据哦"),
          );
        }
      },
      future: HomeApi.getBanner(),
    );
  }

  Widget _initSwiper(BannerEntity banner) {
    return Container(
      height: dp(208),
      child: Swiper(
        itemCount: banner.data.length,
        autoplay: true,
        itemHeight: dp(208),
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.all(5),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            banner.data[index].imagePath,
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, data) {
        if (data.hasData) {
          return Container(
            child: _initItems(data.data),
          );
        } else {
          return Container(
            child: Text("没有数据哦"),
          );
        }
      },
      future: HomeApi.getRecommond(),
    );
  }

  Widget _initItems(RecommondEntity recommond) {
    List<Widget> items = recommond.data.datas.map((data) {
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

    return Column(
      children: items,
    );
  }
}
