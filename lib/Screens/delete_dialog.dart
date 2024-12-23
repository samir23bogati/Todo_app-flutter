import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeleteDialog extends StatelessWidget{
  final VoidCallback onDelete;
  const DeleteDialog({super.key,required this.onDelete});

  @override
  Widget build(BuildContext context){
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Are you sure you want to delete this dialog"),
            const Gap(12),
            const Text("This will remove this data"),
            ElevatedButton(
              child: const Text("delete"),
              onPressed: (){
                Navigator.of(context).pop();
                onDelete();
              },
              ) ,
              OutlinedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                 child: const Text("Cancel"),
              ),
          ],
        ),
        ),
      );
    
  }
}