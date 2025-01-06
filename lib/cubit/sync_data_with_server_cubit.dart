import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/common_state.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/service/database_serice.dart';

class SyncDataWithServerCubit extends Cubit<CommonState> {
  final TodoRepository repository;
  final DatabaseService databaseService= DatabaseService();
  SyncDataWithServerCubit({required this.repository})
   : super(CommonInitialState());

  sync()async{
    final data = await databaseService.notSyncedTodos;
    if (data.isNotEmpty){
      final res =await repository.syncTodoWithServer(data);
      res.fold(
        (err){
          emit(CommonErrorState(message: err));
        },
        (data){
          emit(CommonSuccessState(data: null));
        },
        );
    }

  }
}