import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/common/event/eventbus.dart';
import 'package:flutter_wanandroid_test/common/utils.dart';
import 'package:flutter_wanandroid_test/customWidget/CustomAppBar.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';
import 'package:flutter_wanandroid_test/common/net/user_api.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isShowPassword = true;
  bool isShowRePassword = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.customAppBar(context, "注册"),
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
                    controller: _rePasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: isShowRePassword,
                    maxLines: 1,
                    maxLength: 20,
                    enabled: true,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      hintText: "请输入确认密码",
                      hintStyle: TextStyle(color: Colors.black38),
                      suffixIcon: IconButton(
                          icon: Icon(
                            isShowRePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              isShowRePassword = !isShowRePassword;
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
          InkWell(
            onTap: _register,
            child: Container(
              width: double.infinity,
              height: dp(40),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: dp(10), left: dp(15), right: dp(15)),
              child: Text(
                "注册",
                style: TextStyle(color: Colors.white, fontSize: sp(16)),
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(dp(20))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() {
    UserApi.register(_usernameController.text, _passwordController.text,
            _rePasswordController.text)
        .then((data) {
      SpUtil.add(SpUtil.KEY_USERNAME, _usernameController.text);
      SpUtil.add(SpUtil.KEY_ISLOGIN, true);
      bus.emit(Event.LOGIN, data);
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _rePasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
