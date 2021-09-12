import 'package:flutter/material.dart';
import 'package:flutter_state_management_ex/counter_bloc.dart';
import 'package:flutter_state_management_ex/interval_bloc.dart';

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

  late IntervalBloc intervalBloc;
  late CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();

    intervalBloc = IntervalBloc();
    counterBloc = CounterBloc(intervalBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream Counter')),

      //---------------- Counter Button ----------------//
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => counterBloc.eventSink.add(CounterEvent.Increment),
            child: Text(
              '+',
              style: style,
            ),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () => counterBloc.eventSink.add(CounterEvent.Decrement),
            child: Text(
              '-',
              style: style,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Counter Value */
            StreamBuilder<int>(
              stream: counterBloc.counterStream,
              initialData: 0,
              builder: (context, snapshot) {
                return Text(
                  'Counter: ${snapshot.data}',
                  style: style,
                );
              },
            ),
            SizedBox(
              height: 30,
            ),

            /* Interval */
            StreamBuilder<int>(
              initialData: 1,
              stream: intervalBloc.intervalStream,
              builder: (_, snapshot) {
                print(snapshot.data);
                return Column(
                  children: [
                    Text(
                      'Interval: ${snapshot.data}',
                      style: style,
                    ),
                  ],
                );
              },
            ),

            /* Interval Changer */
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Change Counting Interval',
              ),
              onFieldSubmitted: (String interval) {
                intervalBloc.eventSink.add(
                  ChangeInterval(
                    int.parse(interval),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
