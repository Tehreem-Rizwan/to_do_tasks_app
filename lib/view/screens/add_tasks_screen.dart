import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_task_app/blocs/bloc/tasks_bloc.dart';
import 'package:to_do_task_app/blocs/bloc_exports.dart';
import 'package:to_do_task_app/models/tasks.dart';
import 'package:to_do_task_app/view/services/guid_gen.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Add Task',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: InputDecoration(
                label: Text("Title"), border: OutlineInputBorder()),
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
                    var task = Task(
                        title: titleController.text, id: GUIDGen.generate());
                    context.read<TasksBloc>().add(AddTask(task: task));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
