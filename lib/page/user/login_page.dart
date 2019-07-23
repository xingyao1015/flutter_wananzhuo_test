import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/common/utils.dart';
import 'package:flutter_wanandroid_test/customWidget/CustomAppBar.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_wanandroid_test/common/net/user_api.dart';
import 'package:flutter_wanandroid_test/common/event/eventbus.dart';
import 'package:flutter_wanandroid_test/common/utils/sputil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowPassword = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    SpUtil.get(SpUtil.KEY_USERNAME).then((data) {
      _usernameController.text = data ?? "";
    });
    bus.on(Event.LOGIN, (arg) {
      setState(() {
        Navigator.pop(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.customAppBar(context, "登录"),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: dp(40)),
            child: Image.asset(
              "image/logo.png",
              width: dp(100),
              height: dp(100),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: dp(100), left: dp(15), right: dp(15)),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.orange,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: dp(15)),
                  child: TextField(
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    enabled: true,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      hintText: "请输入用户名",
                      hintStyle: TextStyle(color: Colors.black38),
                      counter: Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                    style: TextStyle(color: Colors.black87, fontSize: sp(12)),
                  ),
                ))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(10)),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Icon(
                  Icons.lock,
                  color: Colors.orange,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: dp(15)),
                  child: TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isShowPassword,
                    maxLines: 1,
                    maxLength: 20,
                    enabled: true,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      hintText: "请输入密码",
                      hintStyle: TextStyle(color: Colors.black38),
                      suffixIcon: IconButton(
                          icon: Icon(
                            isShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                              print(isShowPassword);
                            });
                          }),
                      counter: Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                    style: TextStyle(color: Colors.black87, fontSize: sp(12)),
                  ),
                ))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(right: dp(15), top: dp(5)),
            child: InkWell(
              onTap: () {
                print("忘记密码");
              },
              child: Text(
                "忘记密码？",
                style: TextStyle(fontSize: sp(12), color: Colors.black45),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: dp(40),
            margin: EdgeInsets.only(top: dp(10), left: dp(15), right: dp(15)),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(dp(20))),
            ),
            child: InkWell(
              onTap: _login,
              borderRadius: BorderRadius.all(Radius.circular(dp(20))),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "登录",
                  style: TextStyle(color: Colors.white, fontSize: sp(16)),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: dp(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "新用户？",
                  style: TextStyle(fontSize: sp(12), color: Colors.black54),
                ),
                InkWell(
                  onTap: () {
                    NavigatorUtils.toRegister(context);
                  },
                  child: Text(
                    "点击注册",
                    style: TextStyle(color: Colors.orange, fontSize: sp(12)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _login() {
    if (_usernameController.text == null || _usernameController.text.isEmpty) {
      print("username为空");
      return;
    }

    if (_passwordController.text == null || _passwordController.text.isEmpty) {
      print("password为空");
      return;
    }

    UserApi.login(_usernameController.text, _passwordController.text)
        .then((data) {
      SpUtil.add(SpUtil.KEY_USERNAME, _usernameController.text);
      SpUtil.add(SpUtil.KEY_PASSWORD, _passwordController.text);
      bus.emit(Event.LOGIN, data);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
