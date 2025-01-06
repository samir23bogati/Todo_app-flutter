import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/components/custom_roundedbtm.dart';
import 'package:todo_app/cubit/sync_data_with_server_cubit.dart';

showSyncDataDialog(BuildContext context)async{
  showDialog(
    context: context, 
    builder: (context){
      return const SyncDataDialog();
    },
    );
}

class SyncDataDialog extends StatelessWidget {
  const SyncDataDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sync Data".toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const Gap(12),
                const Text(
                  "Do you want to sync data with the server? if no your locally saved will be lost",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
                ),
                const Gap(12),
                CustomRoundedButton(
                  label:"Sync",
                   onPressed: (){
                    context.read<SyncDataWithServerCubit>().sync();
                    Navigator.pop(context);
                   },
                   )
              ],
            ),
          ),
       Positioned(
        top: 0,
        right: 0,
        child: IconButton(onPressed: (){
          Navigator.pop(context);
        }, 
        icon: const Icon(Icons.close),
        ),)
        ],
      ),
     
    );
  }
}