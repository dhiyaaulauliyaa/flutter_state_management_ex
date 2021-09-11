import 'dart:async';

enum CounterEvent {
  Increment,
  Decrement,
}

class CounterBloc {
  int _count = 0;

  StreamController<CounterEvent> _eventController =
      StreamController<CounterEvent>();
  StreamSink<CounterEvent> get eventSink => _eventController.sink;
  Stream<CounterEvent> get _eventStream => _eventController.stream;

  StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _counterSink => _counterController.sink;
  Stream<int> get counterStream => _counterController.stream;

  CounterBloc() {
    _eventStream.listen((event) {
      _count += event == CounterEvent.Increment ? 1 : -1;
      _counterSink.add(_count);
    });
  }

  void dispose() {
    _eventController.close();
    _counterController.close();
  }
}
