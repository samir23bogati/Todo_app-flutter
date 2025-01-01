import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/cubit/common_state.dart';
import 'package:todo_app/cubit/delete_todo_cubit.dart';
import 'package:todo_app/cubit/update_todo_cubit.dart';
import 'package:todo_app/repository/todo_repository.dart';

import 'add_todo_cubit.dart';

class FetchTodoCubit extends Cubit<CommonState> { 
  final TodoRepository repository;
  final AddTodoCubit addTodoCubit;
  final UpdateTodoCubit updateTodoCubit;
  final DeleteTodoCubit deleteTodoCubit;

  StreamSubscription? _subscription;
  FetchTodoCubit({
    required this.repository,
    required this.addTodoCubit,
    required this.updateTodoCubit,
    required this.deleteTodoCubit,
  }) : super(CommonInitialState()){


    _subscription = Rx.merge([
      addTodoCubit.stream,
      updateTodoCubit.stream,
      deleteTodoCubit.stream,
    ]).listen((event){
      if (event is CommonSuccessState){
        //fetch();
        _refreshLocally();
      }
    });
  }

  fetch() async {
    emit(CommonLoadingState());
    final res = await repository.fetchTodos();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) {
        if(data.isNotEmpty){
          emit(CommonSuccessState(data: data));
        }else{
          emit(CommonNoDataState());
        }
      }
    );
  }

  _refreshLocally(){
    emit(CommonLoadingState());
    if(repository.todos.isNotEmpty){
      emit(CommonSuccessState(data: repository.todos));
    }else{
      emit(CommonNoDataState());
    }
  }
  @override
  Future<void> close(){
    _subscription?.cancel();
    return super.close();
  }
 }