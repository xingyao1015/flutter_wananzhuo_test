import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/net/home_api.dart';
import 'package:flutter_wanandroid_test/common/entity/banner_entity.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';

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
            ],
          ),

          onRefresh: (){
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
      future: getBanner(),
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
