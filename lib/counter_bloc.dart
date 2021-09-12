import 'dart:async';

import 'package:flutter_state_management_ex/interval_bloc.dart';

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

  /* Get Interval */
  int _interval = 1;
  late StreamSubscription<int> _intervalStream;

  CounterBloc(IntervalBloc intervalBloc) {
    _intervalStream = intervalBloc.intervalStream.listen((data) {
      _interval = data;
    });

    _eventStream.listen((event) {
      _count += (event == CounterEvent.Increment ? 1 : -1) * _interval;
      _counterSink.add(_count);
    });
  }

  void dispose() {
    _eventController.close();
    _counterController.close();
    _intervalStream.cancel();
  }
}
