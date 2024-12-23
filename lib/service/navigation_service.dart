import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService {
   static final GlobalKey<NavigatorState> navigationKey = 
   GlobalKey<NavigatorState>();

static Future push( Widget child){
  return navigationKey.currentState!.push(
    PageTransition(
      child: child,
       type:PageTransitionType.fade,
       alignment: Alignment.center,
       ),
  );
}
static Future pushAndReplacement( Widget child){
  return navigationKey.currentState!.pushReplacement(
    PageTransition(
      child: child,
       type:PageTransitionType.fade,
       alignment: Alignment.center,
       ),
  );
}

static void pop(){
 navigationKey.currentState!.pop();
}
}