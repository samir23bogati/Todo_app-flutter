import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/check_connection_cubit.dart';
import 'package:todo_app/cubit/check_data_sync_state.dart';
import 'package:todo_app/service/database_serice.dart';

class CheckDataSyncCubit extends Cubit<CheckDataSyncState> {
final  CheckConnectionCubit checkConnectionCubit;
final DatabaseService databaseService = DatabaseService();

StreamSubscription? _subscription;

CheckDataSyncCubit({required this.checkConnectionCubit})
:super(CheckDataSyncInitial()){
  _subscription = checkConnectionCubit.stream.listen((isInternetAvailable)async{
    if (isInternetAvailable){
      final bool isNotSynced = await databaseService.existAnyNotSyncronizedData;
    if(isNotSynced){
      emit(CheckDataSyncLoading());
      emit(CheckDataSyncExist());
    }else{
      emit(CheckDataSyncLoading());
      emit(CheckDataSyncNotExist());
    }
    }
  });
}

@override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}