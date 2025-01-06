// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/service/database_serice.dart';


class LocalTodoRepository extends TodoRepository {
  final List<Todo> _todos = [];
  // List<Todo> _todos =List.generate(10, 
  // (index) => Todo(
  //   id:Ulid().toUuid(),
  // title: Faker().person.name(),
  // description: Faker().lorem.sentence()),);
  final DatabaseService databaseService = DatabaseService();


  @override
  Future<Either<String, List<Todo>>> fetchTodos() async{
   final todoResp = await databaseService.fetchTodos();
   _todos.clear();
   _todos.addAll(todoResp);
    return Right(todoResp);
  }
  
  @override
  Future<Either<String, Todo>> addTodos({required Todo todo}) async{
   final addedTodo = await databaseService.addTodo(todo);
   _todos.add(addedTodo);
   return Right(addedTodo);
  }
  
  @override
  Future<Either<String, void>> deleteTodos({required String id})async {
   await databaseService.deleteTodo(id);
   _todos.removeWhere((e) => e.id ==id);
   return Right(null);
  }
  
  @override
  Future<Either<String, Todo>> updateTodos({required Todo todo})async {
    final updatedTodo = await databaseService.updateTodo(todo,isOffline: true);
    final index = _todos.indexWhere((e) => e.id == todo.id);
    if (index != -1){
      _todos[index] = updatedTodo;
    }
    return Right(updatedTodo);
  }
  
  @override
  List<Todo> get todos => _todos;
  
  @override
  Future<Either<String, void>> syncTodoWithServer(List<Todo> todos) {
    // TODO: implement syncTodoWithServer
    throw UnimplementedError();
  }
   
}