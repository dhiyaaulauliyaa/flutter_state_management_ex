import 'package:flutter/material.dart';
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
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontSize: 24);

  CounterBloc bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream Counter')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: ()=>bloc.eventSink.add(CounterEvent.Increment),
            child: Text(
              '+',
              style: style,
            ),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            onPressed: ()=>bloc.eventSink.add(CounterEvent.Decrement),
            child: Text(
              '-',
              style: style,
            ),
          )
        ],
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.counterStream,
          initialData: 0,
          builder: (context, snapshot) {
            return Text(
              '${snapshot.data}',
              style: style,
            );
          }
        ),
      ),
    );
  }
}
