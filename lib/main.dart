import 'package:flutter/material.dart';

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

enum CounterEvent {
  Increment,
  Decrement,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontSize: 24);

  int _count = 0;
  int _interval = 1;

  void _counter(CounterEvent event) {
    setState(() {
      _count += _interval * (event == CounterEvent.Increment ? 1 : -1);
    });
  }

  void _changeInterval(String number) {
    setState(() {
      _interval = int.parse(number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stateful Counter')),

      //---------------- Counter Button ----------------//
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _counter(CounterEvent.Increment),
            child: Text(
              '+',
              style: style,
            ),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () => _counter(CounterEvent.Decrement),
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
            /* Counter */
            Text(
              'Count: $_count',
              style: style,
            ),

            /* Interval */
            Text(
              'Interval: $_interval',
              style: style,
            ),

            /* Interval Changer */
            TextFormField(
              initialValue: _interval.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Change Counting Interval'),
              onFieldSubmitted: _changeInterval,
            ),
          ],
        ),
      ),
    );
  }
}
