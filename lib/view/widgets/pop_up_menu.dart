import 'package:flutter/material.dart';
import 'package:to_do_task_app/models/tasks.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislike;

  const PopupMenu({
    Key? key,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislike,
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
                      icon: task.isFavorite == false
                          ? Icon(Icons.bookmark_add_outlined)
                          : Icon(Icons.bookmark_remove),
                      label: task.isFavorite == false
                          ? Text("Add to Bookmarks")
                          : Text("Remove from Bookmarks"),
                    ),
                    onTap: likeOrDislike,
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
