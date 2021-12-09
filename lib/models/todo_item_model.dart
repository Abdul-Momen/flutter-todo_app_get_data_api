// To parse this JSON data, do
//
//     final todoItemModel = todoItemModelFromMap(jsonString);

import 'dart:convert';

class TodoItem {
  TodoItem({
    this.id,
    required this.name,
    this.isComplete = false,
  });

  int? id;
  String name;
  bool isComplete;

  TodoItem copyWith({
    int? id,
    String? name,
    bool? isComplete,
  }) =>
      TodoItem(
        id: id ?? this.id,
        name: name ?? this.name,
        isComplete: isComplete ?? this.isComplete,
      );

  factory TodoItem.fromJson(String str) => TodoItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TodoItem.fromMap(Map<String, dynamic> json) => TodoItem(
        id: json["id"],
        name: json["name"],
        isComplete: json["isComplete"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "isComplete": isComplete,
      };

  static List<TodoItem> listFromMap(String str) =>
      List<TodoItem>.from(json.decode(str).map((x) => TodoItem.fromMap(x)));

  static String listToMap(List<TodoItem> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
