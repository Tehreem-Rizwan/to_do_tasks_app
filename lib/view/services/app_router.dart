import 'package:flutter/material.dart';
import 'package:to_do_task_app/view/screens/recycle_bin.dart';
import 'package:to_do_task_app/view/screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => RecycleBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => TabsScreen());
      default:
        return null;
    }
  }
}
