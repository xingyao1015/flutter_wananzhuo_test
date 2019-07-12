import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid_test/common/entity/custom_url_entity.dart';
import 'package:flutter_wanandroid_test/common/entity/hot_key_entity.dart';
import 'package:flutter_wanandroid_test/common/entity/search_data_entity.dart';
import 'package:flutter_wanandroid_test/common/utils.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_wanandroid_test/common/net/search_api.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchDataData> searchs = [];
  TextEditingController _controller = TextEditingController();
  int requestPage = 0;
  String words;
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: dp(25),
          margin: EdgeInsets.only(right: dp(10)),
          padding: EdgeInsets.only(
            left: dp(10),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(dp(20)))),
          child: TextField(
            enabled: true,
            keyboardType: TextInputType.text,
            maxLines: 1,
            maxLength: 10,
            textAlign: TextAlign.left,
            maxLengthEnforced: true,
            showCursor: true,
            cursorColor: Colors.orange,
            onChanged: (words) {
              this.words = words;
            },
            textInputAction: TextInputAction.search,
            onSubmitted: (words) {
              requestPage = 0;
              searchs.clear();
              _search();
            },
            controller: _controller,
            style: TextStyle(color: Colors.black87, fontSize: sp(12)),
            decoration: InputDecoration(
                counter: Container(
                  width: 0,
                  height: 0,
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(top: dp(5)),
                  child: Icon(Icons.search),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: dp(20)),
                hintText: "输入关键词",
                hintStyle: TextStyle(color: Colors.black45)),
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _initBody(),
    );
  }

  void _search() {
    if (_controller.text == null || _controller.text.isEmpty) {
      return;
    }
    SearchApi.search(_controller.text, requestPage).then((entity) {
      setState(() {
        if (requestPage == 0) {
          isEmpty = entity.data.datas == null || entity.data.datas.isEmpty;
        }
        searchs.addAll(entity.data.datas);
        requestPage++;
      });
    });
  }

  Widget _initBody() {
    if (isEmpty) {
      return _initEmpty();
    } else {
      return _initItem();
    }
  }

  Widget _initItem() {
    List<Widget> items = searchs.map((news) {
      return InkWell(
        onTap: () {
          NavigatorUtils.toWeb(news.link, news.title, context);
        },
        child: Container(
          height: dp(100),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: dp(10), right: dp(10)),
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
                        news.title,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: sp(14), color: Colors.black87),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: dp(10), bottom: dp(10)),
                        child: Text(
                          news.desc,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: sp(12), color: Colors.black54),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.favorite_border),
                          Container(
                            margin:
                                EdgeInsets.only(left: dp(10), right: dp(10)),
                            child: Text(
                              news.author,
                              style: TextStyle(
                                  fontSize: sp(8), color: Colors.black45),
                            ),
                          ),
                          Text(
                            news.niceDate,
                            style: TextStyle(
                                fontSize: sp(8), color: Colors.black45),
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
                    color: _getColor(news.superChapterId),
                    shape: BoxShape.circle),
                child: Text(
                  news.superChapterName,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: sp(12)),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();

    return EasyRefresh(
      firstRefresh: false,
      onRefresh: () {
        requestPage = 0;
        searchs.clear();
        _search();
        return;
      },
      loadMore: () {
        _search();
        return;
      },
      child: ListView(
        shrinkWrap: true,
        children: items,
      ),
    );
  }

  Widget _initEmpty() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(dp(15)),
          child: Text(
            "搜索热词",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: sp(16)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: dp(15), right: dp(15)),
          child: _HotKey(
            pressedWords: (words) {
              requestPage = 0;
              searchs.clear();
              _controller.text = words;
              _search();
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(dp(15)),
          child: Text(
            "常用网站",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: sp(16)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: dp(15), right: dp(15)),
          child: _CustomUrl(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CustomUrl extends StatefulWidget {
  @override
  __CustomUrlState createState() => __CustomUrlState();
}

class __CustomUrlState extends State<_CustomUrl> {
  List<CustomUrlData> datas = [];

  @override
  Widget build(BuildContext context) {
    return _initItems();
  }

  @override
  void initState() {
    _getCustomUrl();
    super.initState();
  }

  void _getCustomUrl() {
    SearchApi.getCustomUrl().then((entity) {
      setState(() {
        datas.addAll(entity.data);
      });
    });
  }

  Widget _initItems() {
    List<Widget> items = datas.map((data) {
      return InkWell(
        onTap: () {
          NavigatorUtils.toWeb(data.link, data.name, context);
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
}

class _HotKey extends StatefulWidget {
  final PressedWords pressedWords;

  const _HotKey({Key key, this.pressedWords}) : super(key: key);

  @override
  __HotKeyState createState() => __HotKeyState();
}

class __HotKeyState extends State<_HotKey> {
  List<HotKeyData> datas = [];

  @override
  Widget build(BuildContext context) {
    return _initItems();
  }

  @override
  void initState() {
    _getHotkey();
    super.initState();
  }

  void _getHotkey() {
    SearchApi.getHotKey().then((entity) {
      setState(() {
        datas.addAll(entity.data);
      });
    });
  }

  Widget _initItems() {
    List<Widget> items = datas.map((data) {
      return InkWell(
        onTap: () {
          widget.pressedWords(data.name);
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
}

typedef PressedWords = void Function(String);

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
