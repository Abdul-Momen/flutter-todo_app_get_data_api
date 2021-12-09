import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/services/db_service.dart';

import 'models/todo_item_model.dart';
import 'package:darq/darq.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> todos = [];

  String description = '';
  final _formKey = GlobalKey<FormState>();

  final DbService _dbService = DbService();

  final ApiService _apiService = ApiService();

  getAllTodo() async {
    // final result = await _apiService.getAllTodo();
    //
    // todos.clear();

    // todos.addAll(result);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // _apiService.getAllTodo().then((value) {
    //   todos.addAll(value);
    //
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, index) {
                var todo = todos[index];
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.pink,
                  )),
                  child: ListTile(
                    onLongPress: () async {
                      Get.defaultDialog(title: "Are you sure?", actions: [
                        TextButton(
                            onPressed: () async {
                              await _apiService.deleteTodo(todo.id!);
                              await getAllTodo();
                              Get.back();
                            },
                            child: Text("Yes")),
                        TextButton(
                            onPressed: () async {
                              Get.back();
                            },
                            child: Text("No"))
                      ]);
                    },
                    leading: Text("${index + 1}"),
                    title: Text(todo.name),
                    trailing: Switch(
                      value: todo.isComplete,
                      onChanged: (bool value) async {
                        todo.isComplete = value;

                        await _apiService.updateTodo(todo.id!, todo);
                        await getAllTodo();
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      onSaved: (value) {
                        description = value!;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        _formKey.currentState!.save();
                        setState(() {});
                        // await _apiService
                        //     .createTodo(TodoItem(name: description));
                        todos.add(TodoItem(name: description));
                        description = '';
                        _formKey.currentState!.reset();
                        await getAllTodo();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
