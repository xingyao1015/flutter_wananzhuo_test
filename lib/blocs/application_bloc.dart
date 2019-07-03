import 'bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc extends BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();

  Sink<int> get _appEventSink => _appEvent.sink;

  Stream<int> get _appEventStream => _appEvent.stream;

  @override
  void dispose() {
    _appEvent.close();
  }

  @override
  Future getData({String lableId, int page}) {
    // TODO: implement getData
    return null;
  }

  @override
  Future loadMore({String lableId}) {
    // TODO: implement loadMore
    return null;
  }

  @override
  Future onRefresh({String lableId}) {
    // TODO: implement onRefresh
    return null;
  }

  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }
}
