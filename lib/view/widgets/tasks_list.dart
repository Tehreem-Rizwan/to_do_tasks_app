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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksList
              .map(
                (task) => ExpansionPanelRadio(
                    value: task.id,
                    headerBuilder: (context, isOpen) => TaskTile(task: task),
                    body: ListTile(
                      title: SelectableText.rich(TextSpan(children: [
                        TextSpan(
                            text: "Text\n",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: task.title),
                        TextSpan(
                            text: "\n\nDescription\n",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: task.description)
                      ])),
                    )),
              )
              .toList(),
        ),
      ),
    );
  }
}
// Expanded(
//       child: ListView.builder(
//         itemCount: tasksList.length,
//         itemBuilder: (context, index) {
//           var task = tasksList[index];
//           return TaskTile(task: task);
//         },
//       ),
//     )