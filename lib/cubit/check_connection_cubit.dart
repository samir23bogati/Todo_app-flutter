import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckConnectionCubit extends Cubit<bool>{
  StreamSubscription? _streamSubscription;

  CheckConnectionCubit() : super(false){
    _streamSubscription = Connectivity().onConnectivityChanged.listen((cons){
      if (cons.contains(ConnectivityResult.none)){
        emit(false);
      }else{
        emit(true);
      }
    });
  }
  @override
  Future<void> close() {
 _streamSubscription?.cancel();
    return super.close();
  }
  }

