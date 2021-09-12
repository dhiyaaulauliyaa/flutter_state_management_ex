import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(0));

  CounterState _executeCounting(int number) {
    if (state is CounterInitial) {
      return CounterCounted((state as CounterInitial).count + number);
    } else
      return CounterCounted((state as CounterCounted).count + number);
  }

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {

    if (event is Increment) {
      yield _executeCounting(1);
    } else if (event is Decrement) {
      yield _executeCounting(-1);
    }
  }
}
