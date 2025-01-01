abstract class CommonState {}

class CommonInitialState extends CommonState{}

class CommonLoadingState extends CommonState{}
class CommonSuccessState<T> extends CommonState{
  //final dynamic data; or generic type ko huna paryo
  final T data;

  CommonSuccessState({required this.data});

}

class CommonErrorState extends CommonState{
  final String message;

  CommonErrorState({required this.message});
}

class CommonNoDataState extends CommonState{}
