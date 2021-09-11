part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class Increment extends CounterEvent {
  Increment();
}

class Decrement extends CounterEvent {
  Decrement();
}