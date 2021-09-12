import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial(0));
  
  CounterState _executeCounting(int number) {
    if (state is CounterInitial) {
      return CounterCounted((state as CounterInitial).count + number);
    } else
      return CounterCounted((state as CounterCounted).count + number);
  }

  void increment(){
     emit (_executeCounting(1));
  }

  void decrement(){
     emit (_executeCounting(-1));
  }
}
