import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier_ex/providers/bg_color.dart';
import 'package:state_notifier_ex/providers/counter.dart';
import 'package:state_notifier_ex/providers/counter_level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<BgColor, BgColorState>(
          create: (context) => BgColor(),
        ),
        StateNotifierProvider<Counter, CounterState>(
          create: (context) => Counter(),
        ),
        StateNotifierProvider<CounterLevel, TotalLevel>(
          create: (context) => CounterLevel(),
        ),
      ],
      child: MaterialApp(
        title: 'StateNofitier',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>();
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<TotalLevel>();
    final appBackgroundColor = switch (levelState) {
      TotalLevel.bronze => Colors.white,
      TotalLevel.silver => Colors.grey,
      TotalLevel.gold => Colors.yellow,
    };

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: const Center(
          child: Text('StateNotifier'),
        ),
        backgroundColor: colorState.color,
      ),
      body: Center(
        child: Text(
          '${counterState.count}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<Counter>().changeCount();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<BgColor>().changeColor();
            },
            tooltip: 'Change Color',
            child: const Icon(Icons.palette),
          )
        ],
      ),
    );
  }
}
