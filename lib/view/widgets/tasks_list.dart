import 'package:flutter/material.dart';
import 'package:to_do_task_app/models/tasks.dart';
import 'package:to_do_task_app/view/widgets/tasks_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasksList,
  });

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (context, index) {
          var task = tasksList[index];
          return TaskTile(task: task);
        },
      ),
    );
  }
}
