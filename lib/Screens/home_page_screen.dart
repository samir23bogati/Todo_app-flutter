// ignore_for_file: prefer_const_constructors

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/Screens/add_todo_screen.dart';
import 'package:todo_app/cubit/check_data_sync_cubit.dart';
import 'package:todo_app/cubit/check_data_sync_state.dart';
import 'package:todo_app/cubit/common_state.dart';
import 'package:todo_app/cubit/delete_todo_cubit.dart';
import 'package:todo_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_app/cubit/sync_data_with_server_cubit.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:todo_app/service/navigation_service.dart';
import 'package:todo_app/widgets/sync_dialog.dart';
import 'package:todo_app/widgets/todo_card.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<String> selectedTodos = [];

  //ValueNotifier<String> _countValueNotifier = ValueNotifier("");

  @override
  void initState() {
    super.initState();
    context.read<FetchTodoCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: BlocSelector<FetchTodoCubit, CommonState, String>(
                selector: (state) {
                  if (state is CommonSuccessState<List<Todo>>) {
                    return state.data.length.toString();
                  } else {
                    return "";
                  }
                },
                builder: (context, state) {
                  return Text(
                    state,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationService.push(const AddTodoScreen());
            //showSyncDataDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<DeleteTodoCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
                if (state is CommonSuccessState) {
                  AnimatedSnackBar.material(
                    'Todo deletedsuccessfully',
                    type: AnimatedSnackBarType.success,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                  ).show(context);
                } else if (state is CommonErrorState) {
                  AnimatedSnackBar.material(
                    state.message,
                    type: AnimatedSnackBarType.error,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                  ).show(context);
                }
              },
            ),
            BlocListener<CheckDataSyncCubit, CheckDataSyncState>(
              listener: (context, state) {
                if (state is CheckDataSyncExist){
                  showSyncDataDialog(context);
                }
              },
            ),
            BlocListener<SyncDataWithServerCubit,CommonState>(
              listener: (context,state){
                if(state is CommonLoadingState){
                  context.loaderOverlay.show();
                }else{
                  context.loaderOverlay.hide();
                }
                 if (state is CommonSuccessState) {
                  AnimatedSnackBar.material(
                    'Todo Synced successfully',
                    type: AnimatedSnackBarType.success,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                  ).show(context);
                } else if (state is CommonErrorState) {
                  AnimatedSnackBar.material(
                    state.message,
                    type: AnimatedSnackBarType.error,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                  ).show(context);
                }
              },
            ),

            

          ],
          child: BlocBuilder<FetchTodoCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonSuccessState<List<Todo>>) {
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return TodoCard(
                      todo: state.data[index],
                      onUpdate: (value) async {
                        NavigationService.push(
                          AddTodoScreen(todo: state.data[index]),
                        );
                      },
                      onDelete: () {
                        context
                            .read<DeleteTodoCubit>()
                            .delete(id: state.data[index].id);
                      },
                    );
                  },
                );
              } else if (state is CommonErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CommonNoDataState) {
                return const Center(
                  child: Text("you have not saved any data yettt!!"),
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(radius: 16),
                );
              }
            },
          ),
        ));
  }
}
