// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:ulid/ulid.dart';
import 'package:faker/faker.dart';


class LocalTodoRepository extends TodoRepository {
  //final List<Todo> _todos = [];
  List<Todo> _todos =List.generate(10, (index) => Todo(
    id:Ulid().toUuid(),
  title: Faker().person.name(),
  description: Faker().lorem.sentence()),);
  @override
  Future<Either<String, List<Todo>>> fetchTodos() async{
    await Future.delayed(Duration(milliseconds: 500));
    return Right(_todos);
  }
  
  @override
  Future<Either<String, Todo>> addTodos({required Todo todo}) {
    // TODO: implement addTodos
    throw UnimplementedError();
  }
  
  @override
  Future<Either<String, void>> deleteTodos({required String id}) {
    // TODO: implement deleteTodos
    throw UnimplementedError();
  }
  
  @override
  Future<Either<String, Todo>> updateTodos({required Todo todo}) {
    // TODO: implement updateTodos
    throw UnimplementedError();
  }
  
  @override
  // TODO: implement todos
  List<Todo> get todos => throw UnimplementedError();
   
}