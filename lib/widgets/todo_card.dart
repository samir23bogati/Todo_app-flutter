import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/Screens/delete_dialog.dart';
import 'package:todo_app/components/custom_tile.dart';
import 'package:todo_app/modals/new_todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;
  final ValueChanged<BuildContext> onUpdate;
  const TodoCard({super.key,
  required this.todo,
  required this.onDelete,required this.onUpdate,});

  @override
  Widget build(BuildContext context) {
    return Slidable(
            key: ValueKey(todo.id),
           endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteDialog(
                          onDelete: onDelete,
                            );
                      },
                        
                        );
                      },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: CupertinoIcons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed:onUpdate,
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.white,
                  icon: CupertinoIcons.delete,
                  label: 'Edit',
                ),
              ],
            ),
            child: CustomTile(
              title: todo.title,
              description: todo.description,
              showCheckbox: false,
              // isCheck:  isSelected,
              // onChanged:  (_) {
                
              //   setState(() {
              //     if( isSelected){
              //     selectedTodos.remove(todo.id);
              //   }else{
              //     selectedTodos.add(todo.id);
              //   }
              //   });
              // },
            ),
            // child: ListTile(
            //   title: Text(_todos[index].title),
            //   subtitle: Text(_todos[index].description),
            //   onTap: () {},
            // ),
          );
  }
}