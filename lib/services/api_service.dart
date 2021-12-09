import 'package:darq/darq.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/todo_item_model.dart';

class ApiService {
  /// API client is used to communicate with REMOTE HTTP API
  final client = GetConnect();

  ///URL of the remote address with endpoint
  final url = "https://flutterfly.prohelika.org/api/todoitems";

  Future<List<TodoItem>> getAllTodo() async {
    List<TodoItem> todos = [];

    ///Actual REST call for GET request
    ///You will usually get JSON data
    var response = await client.get(url);

    /// Parsing JSON to dart types (TodoItem)
    todos = TodoItem.listFromMap(response.bodyString!);

    ///Sort by todo.id
    var sorted = todos.orderByDescending((element) => element.id!).toList();

    return sorted;
  }

  Future<TodoItem> createTodo(TodoItem todoItem) async {
    ///Actual REST call for POST request
    ///A POST request requires a body in JSON format (Dart Map)
    var response = await client.post(url, {"name": todoItem.name});

    return TodoItem.fromJson(response.bodyString!);
  }

  Future<void> updateTodo(int id, TodoItem todoItem) async {
    ///Actual REST call for PUT request
    ///A POST request requires the id in path and the full body of the object in JSON format (Dart Map)
    var response = await client.put("$url/$id", todoItem.toMap());
  }

  Future<void> deleteTodo(int id) async {
    ///Actual REST call for DELETE request
    ///A DELETE request requires id in the path
    var response = await client.delete("$url/$id");
  }
}
