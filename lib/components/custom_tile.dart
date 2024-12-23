import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/extensions/size_extension.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String description;
  final bool showCheckbox;
  final bool isCheck;
  final ValueChanged<bool>? onChanged;

  const CustomTile({super.key,
  required this.title,
  required this.description,
  this.isCheck =false,
  this.showCheckbox = false,
  this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal:12,vertical:6),
      child: Card(
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
        width: context.width,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const Gap(8),
                  Text(description),
                ],
              ),
            ),
            if(showCheckbox)
            Checkbox(
              value: isCheck, 
              onChanged: (value){
                // if (onChanged != null){
                //   onChanged!(value!);
                // }
                onChanged?.call(value!);
              },)
          ],
        ),
        ),
      ),
    );
  }
}