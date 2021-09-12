import 'dart:async';

abstract class IntervalEvent {}

class ChangeInterval extends IntervalEvent {
  int interval;

  ChangeInterval(this.interval);
}

class IntervalBloc {
  StreamController<IntervalEvent> _eventController =
      StreamController<IntervalEvent>();
  StreamSink<IntervalEvent> get eventSink => _eventController.sink;
  Stream<IntervalEvent> get _eventStream => _eventController.stream;

  StreamController<int> _intervalController = StreamController<int>.broadcast();
  StreamSink<int> get _intervalSink => _intervalController.sink;
  Stream<int> get intervalStream => _intervalController.stream;

  IntervalBloc() {
    _eventStream.listen((event) {
      if (event is ChangeInterval) {
        _intervalSink.add(event.interval);
      }
    });
  }

  void dispose() {
    _eventController.close();
    _intervalController.close();
  }

  /* 
    Why use stream.broadcast(): 
    https://stackoverflow.com/questions/51396769/flutter-bad-state-stream-has-already-been-listened-to 
  */
}
