import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/service/database_serice.dart';

class TodoRepositoryImpl extends TodoRepository{
    final Dio dio = Dio();
    final DatabaseService databaseService = DatabaseService();

  TodoRepositoryImpl();
  final List<Todo> _todos =[];
  @override
  List<Todo> get todos => _todos;

  @override
  Future<Either<String, List<Todo>>> fetchTodos() async {
    try {
      final res = await Dio().get(
        "${Constants.baseUrl}/api/notes",
        options: Options(receiveDataWhenStatusError: false),
      );
      final List listTodo = List.from(res.data["data"]);
      final todoList = listTodo.map((e) => Todo.fromMap(e)).toList();
      _todos.clear();
      _todos.addAll(todoList);
      await databaseService.deleteAllTodo();
      for (var val in todoList){
        await databaseService.addTodo(val);
      }
      return Right(todoList);
    } on DioException catch (e) {
      if(e.error is SocketException){
        final localTodoList = await databaseService.fetchTodos();
        if(localTodoList.isNotEmpty){
          _todos.clear();
          _todos.addAll(localTodoList);
          return Right(localTodoList);
        }
        return const Left("No Internet Connection Available!!");
      }
      return Left(e.response?.data["message"] ?? "Unable to fetch todos");
    } catch (e) {
      return Left(e.toString());
    } 
  }
  
  @override
  Future<Either<String, Todo>> addTodos({required Todo todo}) async{
    try {
      final res = await Dio().post(
        "${Constants.baseUrl}/api/notes",
        data: todo.toMap(),
        options: Options(receiveDataWhenStatusError: false),
      );
      final _todo = Todo.fromMap(res.data["data"]);
      await databaseService.addTodo(_todo);
      _todos.add(todo);
      return Right(_todo);
    } on DioException catch (e) {
      if(e.error is SocketException){
       final newTodo = await databaseService.addTodo(todo);
         _todos.add(newTodo);
         return Right(newTodo);
      }
      return Left(e.response?.data["message"] ?? "Unable to add todos");
    } catch (e) {
      return Left(e.toString());
    } 
  }
  
  @override
  Future<Either<String, void>> deleteTodos({required String id})async {
     try {
      final _ = await Dio().delete(
        "${Constants.baseUrl}/api/notes/${id}",
        options: Options(receiveDataWhenStatusError: false),
      );
      _todos.removeWhere((e) => e.id == id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to delete todos");
    } catch (e) {
      return Left(e.toString());
    } 
  }
  
  @override
  Future<Either<String, Todo>> updateTodos({required Todo todo})async {
     try {
      final res = await Dio().put(
        "${Constants.baseUrl}/api/notes/${todo.id}",
        data: todo.toMap(),
        options: Options(receiveDataWhenStatusError: false),
      );
      final _todo = Todo.fromMap(res.data["data"]);
      await databaseService.updateTodo(todo,isOffline: false);
      final index = _todos.indexWhere((e) => e.id == _todo.id);
      if(index != -1){
        _todos[index] = _todo;
      }
      return Right(_todo);
    } on DioException catch (e) {
      if(e.error is SocketException){
       final updatedTodo = await databaseService.updateTodo(todo,isOffline: true);
          final index = _todos.indexWhere((e) => e.id == updatedTodo.id);
      if(index != -1){
        _todos[index] = updatedTodo;
      }
         return Right(updatedTodo);
      
      }
      return Left(e.response?.data["message"] ?? "Unable to update todos");
    } catch (e) {
      return Left(e.toString());
    } 
  }
  
  @override
  Future<Either<String, void>> syncTodoWithServer(List<Todo> todos) async{
    try{
      final _ =
      await Dio().post("${Constants.baseUrl}/api/notes/sync",
       options: Options(receiveDataWhenStatusError: false),
      data:{
        "todo":todos.map((e) => e.toMapId()).toList(),
      });
      return const Right(null);
    }on DioException catch (e){
      if(e.error is SocketException){
        return const Left("No Internet Connection");
      }
      return Left(e.response?.data["message"]?? "unable to sync todos");
    }catch (e){
      return Left(e.toString());
    }
  }
}