// ignore_for_file: public_member_api_docs, sort_constructors_first
class Dog {
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
  }
}
