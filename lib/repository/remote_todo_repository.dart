// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:todo_app/repository/todo_repository.dart';

class RemoteTodoRepository extends TodoRepository {
  final Dio dio = Dio();

  RemoteTodoRepository();
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
      return Right(todoList);
    } on DioException catch (e) {
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
      _todos.add(todo);
      return Right(_todo);
    } on DioException catch (e) {
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
      final index = _todos.indexWhere((e) => e.id == _todo.id);
      if(index != -1){
        _todos[index] = _todo;
      }
      return Right(_todo);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to update todos");
    } catch (e) {
      return Left(e.toString());
    } 
  }
  
  @override
  Future<Either<String, void>> syncTodoWithServer(List<Todo> todos) {
    // TODO: implement syncTodoWithServer
    throw UnimplementedError();
  }
}
