import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/repository/todo_repository_impl.dart';

class MultiRepositoryProviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiRepositoryProviderWrapper({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TodoRepository>(
         // create: (context) => RemoteTodoRepository(),
           //create: (context) => LocalTodoRepository(),
           create:(context) => TodoRepositoryImpl(),
        ),
       
      ],
      child:child,
      );
  }
}