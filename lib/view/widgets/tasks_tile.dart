import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_task_app/models/tasks.dart';
import 'package:to_do_task_app/blocs/bloc/tasks_bloc.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          context.read<TasksBloc>().add(UpdateTask(task: task));
        },
      ),
      onLongPress: () => context.read<TasksBloc>().add(DeleteTask(task: task)),
    );
  }
}
