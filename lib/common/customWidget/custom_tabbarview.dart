import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTabBarView extends StatefulWidget {
  final int keepStateNum;
  final List<Widget> children;
  final TabController controller;
  final ScrollPhysics physics;
  final DragStartBehavior dragStartBehavior;
  final int index;

  const CustomTabBarView(
      {Key key,
      this.keepStateNum,
      @required this.controller,
      this.physics,
      this.dragStartBehavior,
      @required this.children,
      this.index})
      : super(key: key);

  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  @override
  Widget build(BuildContext context) {
    print(widget.index);
    if (widget.dragStartBehavior != null) {
      return TabBarView(
          children: _initChildren(),
          controller: widget.controller,
          physics: widget.physics,
          dragStartBehavior: widget.dragStartBehavior);
    } else {
      return TabBarView(
          children: _initChildren(),
          controller: widget.controller,
          physics: widget.physics);
    }
  }

  List<Widget> _initChildren() {
    List<Widget> children = [];
    for (int i = 0; i < widget.children.length; i++) {
      children.add(CustomTabBarChild(
        index: i,
        parentIndex: widget.index,
        page: widget.children[i],
        keepStateNum: widget.keepStateNum,
      ));
    }
    return children;
  }
}

class CustomTabBarChild extends StatefulWidget {
  final int parentIndex;
  final Widget page;
  final int index;
  final int keepStateNum;

  const CustomTabBarChild(
      {Key key, this.parentIndex, this.page, this.index, this.keepStateNum})
      : super(key: key);

  @override
  _CustomTabBarChildState createState() => _CustomTabBarChildState();
}

class _CustomTabBarChildState extends State<CustomTabBarChild>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("_isKeepState:${_isKeepState()}=====index:${widget.index}=======parentIndex:${widget.parentIndex}");
    return Container(
      child: widget.page,
    );
  }

  bool _isKeepState() {
    if (widget.keepStateNum == null) {
      return false;
    }
    return (widget.index - widget.parentIndex).abs() <=
        widget.keepStateNum ~/ 2;
  }

  @override
  bool get wantKeepAlive => _isKeepState();
}
