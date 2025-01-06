import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/Screens/splash_screen.dart';
import 'package:todo_app/service/navigation_service.dart';
import 'package:todo_app/wrapper/multi_bloc_provider_wrapper.dart';
import 'package:todo_app/wrapper/multi_repository_provider_wrapper.dart';

void main() {
//    databaseFactory = databaseFactory;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProviderWrapper(
      child: MultiBlocProviderWrapper(
        child: GlobalLoaderOverlay(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo',
            theme: ThemeData(
              useMaterial3: false,
              primarySwatch: Colors.red,
            ),
            navigatorKey: NavigationService.navigationKey,
            //home:const HomePageScreen(),
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
