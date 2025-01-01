import 'package:todo_app/cubit/common_state.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteTodoCubit extends Cubit<CommonState>{
  final TodoRepository repository;

  DeleteTodoCubit({ required this.repository}):
  super(CommonInitialState());


delete({required String id}) async{
  emit(CommonLoadingState());
  final res =await repository.deleteTodos(id:id);
  
 res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (_) => emit(CommonSuccessState(data: null)),
    );
  }
}