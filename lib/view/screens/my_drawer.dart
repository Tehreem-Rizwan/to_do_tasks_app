import 'package:flutter/material.dart';
import 'package:to_do_task_app/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:to_do_task_app/blocs/bloc_exports.dart';
import 'package:to_do_task_app/view/screens/recycle_bin.dart';
import 'package:to_do_task_app/view/screens/tasks_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: Text(
                "Task Drawer",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
              return GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(TasksScreen.id),
                child: ListTile(
                  leading: Icon(Icons.folder_special),
                  title: Text("My Tasks"),
                  trailing: Text("${state.allTasks.length}"),
                ),
              );
            }),
            Divider(),
            BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
              return GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                child: ListTile(
                  leading: Icon(Icons.folder_special),
                  title: Text("Bin"),
                  trailing: Text('${state.removedTasks.length}'),
                ),
              );
            }),
            Switch(
                value: switchValue,
                onChanged: (newValue) {
                  setState(() {
                    switchValue = newValue;
                  });
                })
          ],
        ),
      ),
    );
  }
}
