import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_task_app/blocs/switch_bloc/switch_bloc.dart';
import 'package:to_do_task_app/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:to_do_task_app/blocs/bloc_exports.dart';
import 'package:to_do_task_app/view/screens/recycle_bin.dart';
import 'package:to_do_task_app/view/screens/tabs_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
                    Navigator.of(context).pushReplacementNamed(TabsScreen.id),
                child: ListTile(
                  leading: Icon(Icons.folder_special),
                  title: Text("My Tasks"),
                  trailing: Text(
                      "${state.pendingTasks.length} |${state.completedTasks.length}"),
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
            BlocBuilder<SwitchBloc, SwitchState>(builder: (context, state) {
              return Switch(
                  value: state.switchValue,
                  onChanged: (newValue) {
                    newValue
                        ? context.read<SwitchBloc>().add(SwitchOnEvent())
                        : context.read<SwitchBloc>().add(SwitchOffEvent());
                  });
            })
          ],
        ),
      ),
    );
  }
}
