import 'package:flutter/material.dart';
import 'package:to_do_task_app/view/screens/my_drawer.dart';
import 'package:to_do_task_app/view/widgets/tasks_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = "recycle_bin_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Recycle Bin",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
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
                " Tasks",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
          TasksList(tasksList: []),
        ],
      ),
    );
  }
}
