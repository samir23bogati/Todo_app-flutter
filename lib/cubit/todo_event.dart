import 'package:todo_app/modals/new_todo.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent{
  final Todo todo;

  AddTodoEvent({required this.todo});
  
}
