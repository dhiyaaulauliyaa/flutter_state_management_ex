import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management_ex/counter_bloc.dart';

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
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
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

  @override
  Widget build(BuildContext context) {
    CounterBloc bloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('BLoC Counter')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => bloc.add(CounterEvent.Increment),
            child: Text(
              '+',
              style: MyHomePage.style,
            ),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () => bloc.add(CounterEvent.Decrement),
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
            BlocBuilder<CounterBloc, int>(
              builder: (context, state) {
                return Text(
                  'BLoC Builder: ${state.toString()}',
                  style: MyHomePage.style,
                );
              },
            ),

            /* BLoC Listener: execute logic on listener function every state change (doesn't rebuild UI) */
            BlocListener<CounterBloc, int>(
              listener: (context, state) {
                setState(() {
                  _counterWithListener = state;
                });
              },
              child: Text(
                'BLoC Listener: ${_counterWithListener.toString()}',
                style: MyHomePage.style,
              ),
            ),

            /* BLoC Consumer: Combination of Listener and Builder */
            BlocConsumer(
              bloc: BlocProvider.of<CounterBloc>(context),
              listener: (context, state) {
                setState(() {
                  print(state.toString());
                  // _counterWithListener = state.toString();
                });
              },
              builder: (context, state) {
                return Text(
                  'BLoC Consumer: ${state.toString()}',
                  style: MyHomePage.style,
                );
              },
            ),

            /* StreamBuilder: Use bloc stream */
            StreamBuilder(
              stream: bloc.stream,
              initialData: 0,
              builder: (context, state) {
                return Text(
                  'BLoC Stream: ${state.data}',
                  style: MyHomePage.style,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
