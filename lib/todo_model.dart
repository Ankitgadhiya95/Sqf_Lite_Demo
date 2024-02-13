import 'dart:core';

class ToDoModel {
  final int id;
  final String title;
  final String description;

  ToDoModel({required this.id, required this.title, required this.description});

  factory ToDoModel.fromJson(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'id': id, 'description': description};
  }
}
