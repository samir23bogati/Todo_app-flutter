import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/counter_repository.dart';

abstract class CounterState {}

class CounterLoading extends CounterState {}

class CounterSuccess extends CounterState {
  final int count;

  CounterSuccess({required this.count});
}

class CounterErrorState extends CounterState {
  final String message;

  CounterErrorState({required this.message});
}

class CounterCubit extends Cubit<CounterState> {
  final CounterRepository counterRepository;

  CounterCubit({required this.counterRepository})
      : super(CounterSuccess(count: counterRepository.count));

  Future<void> increment() async {
    try {
      emit(CounterLoading());
      await counterRepository.increment();
      emit(CounterSuccess(count: counterRepository.count));
    } catch (e) {
      emit(CounterErrorState(message: e.toString()));
    }
  }
}
