import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_task_app/blocs/bloc_exports.dart';
import 'package:to_do_task_app/models/tasks.dart';
import 'package:to_do_task_app/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:to_do_task_app/view/widgets/pop_up_menu.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.star_outline),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.date)))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                  value: task.isDone,
                  onChanged: task.isDeleted == false
                      ? (value) {
                          context.read<TasksBloc>().add(UpdateTask(task: task));
                        }
                      : null),
              PopupMenu(
                cancelOrDeleteCallback: () =>
                    _removeorDeleteTask(context, task),
                task: task,
              )
            ],
          ),
        ],
      ),
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