import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/delete_todo_cubit.dart';
import 'package:todo_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_app/cubit/update_todo_cubit.dart';
import 'package:todo_app/repository/todo_repository.dart';

class MultiBlocProviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocProviderWrapper({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddTodoCubit(
              repository: context.read<TodoRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UpdateTodoCubit(
              repository: context.read<TodoRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => DeleteTodoCubit(
              repository: context.read<TodoRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FetchTodoCubit(
              repository: context.read<TodoRepository>(),
              addTodoCubit: context.read<AddTodoCubit>(),
              updateTodoCubit: context.read<UpdateTodoCubit>(),
              deleteTodoCubit: context.read<DeleteTodoCubit>(),
            ),
          ),
        ],
        child: child,
    );
  }
}