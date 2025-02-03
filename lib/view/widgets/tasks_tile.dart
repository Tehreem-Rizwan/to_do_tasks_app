import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_task_app/blocs/bloc_exports.dart';
import 'package:to_do_task_app/models/tasks.dart';
import 'package:to_do_task_app/blocs/tasks_bloc/tasks_bloc.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;
  void _removeorDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.star_outline),
            Text(
              task.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  decoration: task.isDone! ? TextDecoration.lineThrough : null),
            ),
          ],
        ),
        Checkbox(
            value: task.isDone,
            onChanged: task.isDeleted == false
                ? (value) {
                    context.read<TasksBloc>().add(UpdateTask(task: task));
                  }
                : null),
      ],
    );
  }
}
// ListTile(
//         title: Text(
//           task.title,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//               decoration: task.isDone! ? TextDecoration.lineThrough : null),
//         ),
//         trailing: Checkbox(
//             value: task.isDone,
//             onChanged: task.isDeleted == false
//                 ? (value) {
//                     context.read<TasksBloc>().add(UpdateTask(task: task));
//                   }
//                 : null),
//         onLongPress: () => _removeorDeleteTask(context, task));