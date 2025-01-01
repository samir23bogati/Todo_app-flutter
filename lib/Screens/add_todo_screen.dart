import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/components/custom_roundedbtm.dart';
import 'package:todo_app/components/custom_text_field.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/todo_event.dart';
import 'package:todo_app/cubit/update_todo_cubit.dart';
import 'package:todo_app/cubit/common_state.dart';
import 'package:todo_app/modals/new_todo.dart';

// typedef NewTodo =({String title,String description});

class AddTodoScreen extends StatefulWidget {
  final Todo? todo;
  const AddTodoScreen({super.key,this.todo});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  
  final GlobalKey<FormBuilderState> _formKey =GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.todo != null ? "Update" : "Add "}Todo"),
      ),
      body:MultiBlocListener(
        listeners: [
 BlocListener<AddTodoCubit, CommonState>(
        listener: (context,state){
         if(state is CommonLoadingState){
          context.loaderOverlay.show();
         }else {
          context.loaderOverlay.hide();
         }
         if (state is CommonSuccessState){
          AnimatedSnackBar.material(
            'Todo added successfully',
            type:AnimatedSnackBarType.success,
            mobileSnackBarPosition:MobileSnackBarPosition.bottom,
          ).show(context);
          //context.read<FetchTodoCubit>().fetch();
            Navigator.of(context).pop();
         }else if(state is CommonErrorState){
          AnimatedSnackBar.material(
            state.message,
            type:AnimatedSnackBarType.error,
             mobileSnackBarPosition:MobileSnackBarPosition.bottom,
            ).show(context);
         }
        },
 ),
BlocListener<UpdateTodoCubit, CommonState>(
        listener: (context,state){
         if(state is CommonLoadingState){
          context.loaderOverlay.show();
         }else {
          context.loaderOverlay.hide();
         }
         if (state is CommonSuccessState){
          AnimatedSnackBar.material(
            'Todo updated successfully',
            type:AnimatedSnackBarType.success,
            mobileSnackBarPosition:MobileSnackBarPosition.bottom,
          ).show(context);
          //context.read<FetchTodoCubit>().fetch();
            Navigator.of(context).pop();
         }else if(state is CommonErrorState){
          AnimatedSnackBar.material(
            state.message,
            type:AnimatedSnackBarType.error,
             mobileSnackBarPosition:MobileSnackBarPosition.bottom,
            ).show(context);
         }
        },
 ),
 ],
      child: Container(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                name:"title",
                label: "Title",
                 labelText: "Title",
                  hintText: "Enter any title",
                  initialValue: widget.todo?.title,
                  prefixIcon: Icons.title,
                   maxLength: 51,
                   validator: (value){
                    if(value?.isEmpty ?? true){
                      return "Title field cannot be empty";
                    }
                      return null;
                    
                   },
              ),
               CustomTextField(
                name:"description",
                label: "description",
                 labelText: "Description",
                 maxLines: 3,
                  hintText: "Enter any description",
                   initialValue: widget.todo?.title,
                  prefixIcon: Icons.person,
                   maxLength: 200,
                   validator: (value){
                    if(value?.isEmpty ?? true){
                      return "Description field cannot be empty";
                    }
                      return null;
                    
                   },
              ),
              CustomRoundedButton(
                label: widget.todo != null? "Update": "Save",
                 onPressed: () {
                   if (_formKey.currentState!.saveAndValidate()){
                   Todo todo =  Todo.fromLocalMap( _formKey.currentState!.value);
                    if(widget.todo == null){
                      context
                      .read<AddTodoCubit>()
                      .add(AddTodoEvent(todo: todo));
                    }else {
                        context.read<UpdateTodoCubit>().update(
                          todo: todo.copyWith(
                          id:widget.todo!.id
                        ));
                    
                     // updateTodo(payload: _formKey.currentState!.value, );
                   }
                 }
               
                 },
                 )
            ],
          ),
        ),
      ),
    ),
    );
  }
}