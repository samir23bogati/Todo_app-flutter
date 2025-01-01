import 'package:todo_app/cubit/common_state.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTodoCubit extends Cubit<CommonState>{
  final TodoRepository repository;
  UpdateTodoCubit({ required this.repository}):
  super(CommonInitialState());


update({required Todo todo}) async{
  emit(CommonLoadingState());
  final res =await repository.updateTodos(todo:todo);
  res.fold(
    (err) => emit(CommonErrorState(message:err)),
    (data) => emit(CommonSuccessState(data:data)),
  );
}
}