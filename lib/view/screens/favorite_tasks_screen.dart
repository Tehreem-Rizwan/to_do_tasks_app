import 'package:flutter/material.dart';
import 'package:to_do_task_app/blocs/bloc_exports.dart';
import 'package:to_do_task_app/models/tasks.dart';
import 'package:to_do_task_app/view/screens/add_tasks_screen.dart';
import 'package:to_do_task_app/view/widgets/tasks_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({super.key});
  static const id = "tasks_screen";

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.favoriteTasks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.grey, width: 1),
                ),
                label: Text(
                  "${tasksList.length} Tasks",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            TasksList(tasksList: tasksList),
          ],
        );
      },
    );
  }
}
