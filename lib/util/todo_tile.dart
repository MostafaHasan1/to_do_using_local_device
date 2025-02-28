import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

   TodoTile({
     super.key,
     required this.taskName,
     required this.taskCompleted,
     required this.onChanged,
     required this.deleteFunction,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(onPressed: deleteFunction, icon: Icons.delete, backgroundColor: Colors.red.shade300,borderRadius: BorderRadius.circular(12),)
            ]),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              //checkboox
              Checkbox(value: taskCompleted, onChanged: onChanged, activeColor: Colors.black,),

              //taks name
              Text(taskName,
              style: TextStyle(decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none),),
            ],
          ),
        ),
      ),
    );
  }
}
