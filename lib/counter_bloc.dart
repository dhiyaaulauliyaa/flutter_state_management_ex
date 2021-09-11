import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent {
  Increment,
  Decrement,
}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  int _count = 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    _count += event == CounterEvent.Increment ? 1 : -1;
    yield _count;
  }

   @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    // print(event);
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    // print(change);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    // print(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}