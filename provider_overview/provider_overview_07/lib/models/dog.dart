import 'package:flutter/material.dart';

class Dog with ChangeNotifier {
  Dog({
    required this.name,
    required this.breed,
    this.age = 1,
  });

  final String name;
  final String breed;
  int age;

  void grow() {
    age++;
    notifyListeners();
  }
}
