// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/components/custom_roundedbtm.dart';
import 'package:todo_app/components/custom_text_field.dart';
import 'package:todo_app/constants/constants.dart';
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

  void addTodo({required String title,required String description}) async {
try{
  context.loaderOverlay.show();
  final payload ={
    "title":title,
    "description":description,
  };

  final res = await Dio().post(
    "${Constants.baseUrl}/api/notes",
    data: payload,
    );

    if(res.statusCode ==200){
      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Note Added Successfully"),
    ),
  );
  Navigator.of(context).pop(true);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res.data["message"]?? "unable to post data"),
      ),
      );
    }
}on DioException catch(e){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(e.response?.data["message"]?? "unable to post data"),
    ),
  );

}catch(e){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Unable to post data")),
  );
}finally{
   context.loaderOverlay.hide();
}
  }

  void updateTodo({
    required String id,
    required String title,
    required String description,
  }) async {
    try {
      context.loaderOverlay.show(); // Show loading indicator
      final payload = {
        "title": title,
        "description": description,
      };
       final res = await Dio().put(
        "${Constants.baseUrl}/api/notes/$id", //  use the todo ID for the request
        data: payload,
      );

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Note Updated Successfully")), // Updated success message
        );
        Navigator.of(context).pop(true); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res.data["message"] ?? "Unable to update data")),
        );
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response?.data["message"] ?? "Unable to update data")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unable to update data")),
      );
    } finally {
      context.loaderOverlay.hide(); 
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.todo != null ? "Update" : "Add "}Todo"),
      ),
      body: Container(
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
                    if(widget.todo == null){
                      addTodo(
                        title: _formKey.currentState!.value["title"], 
                      description:_formKey.currentState!.value["description"],
                      );
                    }else {
                      // Update existing todo
                      updateTodo(
                        id: widget.todo!.id, // Pass the ID of the todo
                        title: _formKey.currentState!.value["title"],
                        description: _formKey.currentState!.value["description"],
                      );
                    // final Todo param = Todo(
                    //   id:widget.todo?.id ?? Ulid().toUuid(),
                    //   title:_formKey.currentState!.value["title"],
                      
                    //   description:_formKey.currentState!.value["description"]);
                    //   widget.onSavedOrUpdate(param);
                    //   NavigationService.pop();
                   }
                 }
               
                 },
                 )
            ],
          ),
        ),
      ),
    );
  }
}