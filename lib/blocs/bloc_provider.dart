import 'package:flutter/material.dart';

abstract class BlocBase {
  Future getData({String lableId, int page});

  Future onRefresh({String lableId});

  Future loadMore({String lableId});

  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;
  final bool userDispose;

  const BlocProvider(
      {Key key, @required this.bloc, this.userDispose, @required this.child})
      : super(key: key);

  @override
  _BlocProviderState createState() => _BlocProviderState();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static _typeOf<T>() => T;
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    if (widget.userDispose) widget.bloc.dispose();
    super.dispose();
  }
}
