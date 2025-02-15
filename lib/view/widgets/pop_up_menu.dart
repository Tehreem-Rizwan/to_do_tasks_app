import 'package:flutter/material.dart';
import 'package:to_do_task_app/models/tasks.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;

  const PopupMenu({
    Key? key,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislikeCallback,
    required this.task,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? ((context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: editTaskCallback,
                        icon: Icon(Icons.edit),
                        label: Text("Edit")),
                    onTap: null,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavorite == false
                          ? Icon(Icons.bookmark_add_outlined)
                          : Icon(Icons.bookmark_remove),
                      label: task.isFavorite == false
                          ? Text("Add to\nBookmarks")
                          : Text("Remove from \nBookmarks"),
                    ),
                    onTap: likeOrDislikeCallback,
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
                    onTap: restoreTaskCallback,
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
