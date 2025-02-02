import 'package:flutter/material.dart';
import 'package:to_do_task_app/view/screens/add_tasks_screen.dart';
import 'package:to_do_task_app/view/screens/completed_tasks_screen.dart';
import 'package:to_do_task_app/view/screens/favorite_tasks_screen.dart';
import 'package:to_do_task_app/view/screens/my_drawer.dart';
import 'package:to_do_task_app/view/screens/pending_tasks.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});
  static const id = "tabs_screen";

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': PendingTasksScreen(), "title": "Pending Tasks"},
    {'pageName': CompletedTasksScreen(), "title": "Completed Tasks"},
    {'pageName': FavoriteTasksScreen(), "title": "FavoriteTasks"},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle_sharp),
                label: "Pending Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.done), label: "Completed Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite Tasks")
          ]),
    );
  }
}
