import 'dart:math';

class CounterRepository{
  int _count =0;

   int get count => _count;

   Future<void> increment() async{
    if (Random().nextBool()){
    await Future.delayed(const Duration(milliseconds:500));
    _count++;
   }else{
    throw Exception("Unable to increase counter");
   }
   }
}