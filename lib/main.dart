import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_ex/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      /* BLoC Provider: Provides BLoC for its children */
      home: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static final TextStyle style = TextStyle(fontSize: 24);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterWithListener = 0;

  int _stateSwitcher(dynamic state) {
    if (state is CounterInitial) {
      return state.count;
    } else if (state is CounterCounted) {
      return state.count;
    } else
      return -1000;
  }

  @override
  Widget build(BuildContext context) {
    CounterCubit cubit = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      appBar: AppBar(title: Text('BLoC Counter')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => cubit.increment(),
            child: Text(
              '+',
              style: MyHomePage.style,
            ),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () => cubit.decrement(),
            child: Text(
              '-',
              style: MyHomePage.style,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* BLoC Builder: rebuild every state change */
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) => Text(
                'BLoC Builder: ${_stateSwitcher(state)}',
                style: MyHomePage.style,
              ),
            ),

            /* BLoC Listener: execute logic on listener function every state change (doesn't rebuild UI) */
            BlocListener<CounterCubit, CounterState>(
              listener: (context, state) {
                setState(() {
                  _counterWithListener = _stateSwitcher(state);
                });
              },
              child: Text(
                'BLoC Listener: ${_counterWithListener.toString()}',
                style: MyHomePage.style,
              ),
            ),

            /* BLoC Consumer: Combination of Listener and Builder */
            BlocConsumer(
              bloc: BlocProvider.of<CounterCubit>(context),
              listener: (context, state) {
                setState(() {
                  print('BLoC Consumer-Listener: ${_stateSwitcher(state)}');
                  // _counterWithListener = state.toString();
                });
              },
              builder: (context, state) => Text(
                'BLoC Consumer: ${_stateSwitcher(state)}',
                style: MyHomePage.style,
              ),
            ),

            /* StreamBuilder: Use bloc stream */
            StreamBuilder(
              stream: cubit.stream,
              initialData: CounterInitial(0),
              builder: (context, state) => Text(
                'BLoC Stream: ${_stateSwitcher(state.data)}',
                style: MyHomePage.style,
              ),
            )
          ],
        ),
      ),
    );
  }
}
