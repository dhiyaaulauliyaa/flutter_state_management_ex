part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {
  final int count;
  CounterInitial(this.count);
}

class CounterCounted extends CounterState {
  final int count;
  CounterCounted(this.count);
}
