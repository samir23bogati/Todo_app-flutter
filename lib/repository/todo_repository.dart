import 'package:dartz/dartz.dart';
import 'package:todo_app/modals/new_todo.dart';

abstract class TodoRepository {

  List<Todo> get todos;
  
  Future<Either<String,List<Todo>>> fetchTodos();


  Future<Either<String,Todo>> addTodos({required Todo todo});


  Future<Either<String,Todo>> updateTodos({required Todo todo});


  Future<Either<String,void>> deleteTodos({required String id});
}