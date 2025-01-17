import 'package:flutter/material.dart';
import 'package:todo_app/Screens/home_page_screen.dart';
import 'package:todo_app/service/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),
    () {
      NavigationService.pushAndReplacement(const HomePageScreen());
    },);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 189,
        ),
      ),
    );
  }
}