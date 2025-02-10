import 'package:flutter/material.dart';
import 'package:to_do_task_app/models/tasks.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  const PopupMenu({
    Key? key,
    required this.cancelOrDeleteCallback,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? ((context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.edit),
                        label: Text("Edit")),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.bookmark),
                      label: Text("Add to Bookmarks"),
                    ),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.delete),
                        label: Text("Delete")),
                    onTap: cancelOrDeleteCallback,
                  )
                ])
            : (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.restore_from_trash),
                        label: Text("Restore")),
                    onTap: cancelOrDeleteCallback,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.delete_forever),
                        label: Text("Delete Forever")),
                    onTap: cancelOrDeleteCallback,
                  )
                ]);
  }
}
