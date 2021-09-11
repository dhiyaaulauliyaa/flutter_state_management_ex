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

  void _counter(CounterEvent event) {
    setState(() {
      _count += event == CounterEvent.Increment ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stateful Counter')),
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
      body: Center(
        child: Text(
          '$_count',
          style: style,
        ),
      ),
    );
  }
}
