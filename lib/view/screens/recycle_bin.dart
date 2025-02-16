import 'package:flutter/material.dart';
import 'package:to_do_task_app/blocs/bloc_exports.dart';
import 'package:to_do_task_app/view/screens/my_drawer.dart';
import 'package:to_do_task_app/view/widgets/tasks_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = "recycle_bin_screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Recycle Bin",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: TextButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.delete_forever),
                              label: Text("Delete all Tasks")),
                          onTap: () =>
                              context.read<TasksBloc>().add(DeleteAllTasks()))
                    ])
          ],
        ),
        drawer: MyDrawer(),
        body: Column(
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
                  "${state.removedTasks.length} Tasks",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            TasksList(tasksList: state.removedTasks),
          ],
        ),
      );
    });
  }
}
