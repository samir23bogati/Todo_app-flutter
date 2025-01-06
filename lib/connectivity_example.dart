
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/check_connection_cubit.dart';

class ConnectivityExample extends StatefulWidget {
  const ConnectivityExample({super.key});

  @override
  State<ConnectivityExample> createState() => _ConnectivityExampleState();
}

class _ConnectivityExampleState extends State<ConnectivityExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<CheckConnectionCubit,bool>(
              builder: (context,state){
                return Text(
                  state ? "Connected":"Not Connected",
                  style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
                );
              },
              ),
            ],
          ),
        )
      ),
    );
  }
}