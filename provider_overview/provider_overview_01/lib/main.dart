import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Counter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.blue[100],
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Counter Page',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CounterA(
              counter: _counter,
              increment: _incrementCounter,
            ),
            const SizedBox(
              height: 20,
            ),
            Middle(
              counter: _counter,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterA extends StatelessWidget {
  const CounterA({
    super.key,
    required this.counter,
    required this.increment,
  });

  final int counter;
  final void Function() increment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[100],
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            '$counter',
            style: const TextStyle(fontSize: 48),
          ),
          ElevatedButton(
              onPressed: increment,
              child: const Text(
                'Increment',
                style: TextStyle(
                  fontSize: 20,
                ),
              ))
        ],
      ),
    );
  }
}

class Middle extends StatelessWidget {
  const Middle({
    super.key,
    required this.counter,
  });

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CounterB(
              counter: counter,
            ),
            const SizedBox(
              width: 20,
            ),
            Sibling()
          ]),
    );
  }
}

class CounterB extends StatelessWidget {
  const CounterB({
    super.key,
    required this.counter,
  });

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[100],
      padding: const EdgeInsets.all(10),
      child: Text(
        '$counter',
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}

class Sibling extends StatelessWidget {
  const Sibling({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[100],
      padding: const EdgeInsets.all(10),
      child: const Text(
        'Sibling',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
