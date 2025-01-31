import 'package:flutter/material.dart';

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
            ListTile(
              leading: Icon(Icons.folder_special),
              title: Text("My Tasks"),
              trailing: Text('0'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.folder_special),
              title: Text("Bin"),
              trailing: Text('0'),
            )
          ],
        ),
      ),
    );
  }
}
