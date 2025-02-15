import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_task_app/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:to_do_task_app/blocs/bloc_exports.dart';
import 'package:to_do_task_app/models/tasks.dart';
import 'package:to_do_task_app/view/services/guid_gen.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;

  EditTaskScreen({
    super.key,
    required this.oldTask,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController desciptionController =
        TextEditingController(text: oldTask.description);

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Edit Task',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: InputDecoration(
                  label: Text("Title"), border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            controller: desciptionController,
            decoration: InputDecoration(
                label: Text("Description"), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel", style: TextStyle(color: Colors.red))),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    var editedTask = Task(
                        title: titleController.text,
                        description: desciptionController.text,
                        date: DateTime.now().toString(),
                        id: oldTask.id,
                        isDone: false,
                        isFavorite: oldTask.isFavorite);

                    context
                        .read<TasksBloc>()
                        .add(EditTask(oldTask: oldTask, newTask: editedTask));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
