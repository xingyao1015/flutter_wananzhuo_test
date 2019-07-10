import 'package:flutter/material.dart';
import 'package:flutter_wanandroid_test/resources/resources.dart';

class CustomAppBar{
  static AppBar customAppBar(BuildContext context,String title){
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.white,fontSize: sp(16)),
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
      centerTitle: true,
    );
  }
}
