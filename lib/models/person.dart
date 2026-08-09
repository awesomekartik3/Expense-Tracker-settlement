import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Person {
  final String id;
  String name;

  Person({
    String? id,
    required this.name,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json['id'] as String,
        name: json['name'] as String,
      );
}
