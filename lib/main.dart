import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/Screens/splash_screen.dart';
import 'package:todo_app/service/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) { 
    
    return GlobalLoaderOverlay(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.red,
        ),
        navigatorKey: NavigationService.navigationKey,
        //home:const HomePageScreen(),
        home:const SplashScreen(),
      ),
    );
  }
}