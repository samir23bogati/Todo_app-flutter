import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/add_todo_screen.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:todo_app/service/navigation_service.dart';
import 'package:todo_app/widgets/todo_card.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Todo> _todos = []; 

  Future<List<Todo>> fetchTodos() async {
    final res = await Dio().get("${Constants.baseUrl}/api/notes");
    if (res.statusCode == 200) {
      final List<dynamic> listTodo = res.data["data"];
      final todoList = listTodo.map((e) => Todo.fromMap(e)).toList();
      setState(() {
        _todos = todoList; 
      });
      return todoList;
    } else {
      throw Exception(res.data?["message"] ?? "Unable to fetch notes");
    }
  }

  void onAddOrUpdate(Todo todo) {
    setState(() {
      final index = _todos.indexWhere((e) => e.id == todo.id);
      if (index != -1) {
        _todos[index] = todo;
      } else {
        _todos.add(todo);
      }
    });
  }

  void onDelete(Todo todo) {
    setState(() {
      _todos.removeWhere((e) => e.id == todo.id);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await NavigationService.push(const AddTodoScreen());
          if (res == true) {
            fetchTodos(); 
          }
        },
        child: const Icon(Icons.add),
      ),
      body: _todos.isNotEmpty 
          ? ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return TodoCard(
                  todo: _todos[index],
                  onDelete: () => onDelete(_todos[index]),
                );
              },
            )
          : const Center(
              child: Text("You have not saved any todos yet!"),
            ),
    );
  }
}
