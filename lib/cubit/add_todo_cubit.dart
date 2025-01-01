import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:todo_app/cubit/common_state.dart';
import 'package:todo_app/cubit/todo_event.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoCubit extends Bloc<TodoEvent,CommonState>{
  final TodoRepository repository;
  AddTodoCubit({ required this.repository}):
  super(CommonInitialState()){
  on<AddTodoEvent>((event, emit) async{
   
  
  emit(CommonLoadingState());
  final res = await repository.addTodos(todo:event.todo);
  res.fold(
    (err) => emit(CommonErrorState(message:err)),
    (data) => emit(CommonSuccessState(data:data)),
  );
},
transformer: droppable(),
);

  }



}