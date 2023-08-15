import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Dog>(
      create: (context) => Dog(
        name: 'dog08',
        breed: 'breed08',
        age: 3,
      ),
      child: MaterialApp(
        title: 'Provider 10',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 10'),
      ),
      body: Selector<Dog, String>(
        selector: (context, value) => value.name,
        builder: (_, value, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '- name: $value',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BreedAndAge(),
              ],
            ),
          );
        },
        child: const Text(
          'I like dogs',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<Dog, String>(
      selector: (context, value) => value.breed,
      builder: (_, value, __) {
        return Column(
          children: [
            Text(
              '- breed: $value',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Age(),
          ],
        );
      },
    );
  }
}

class Age extends StatelessWidget {
  const Age({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<Dog, int>(
      selector: (context, value) => value.age,
      builder: (_, value, __) {
        return Column(
          children: [
            Text(
              '- age: $value',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => context.read<Dog>().grow(),
              child: const Text(
                'Grow',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        );
      },
    );
  }
}
