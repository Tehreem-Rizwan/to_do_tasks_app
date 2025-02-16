import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_task_app/models/tasks.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    _loadTasks(); // Load tasks on app start

    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnFavoriteTask>(_onMarkFavoriteOrUnFavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? allTasksString = prefs.getString('all_tasks');
    final String? removedTasksString = prefs.getString('removed_tasks');

    List<Task> allTasks = allTasksString != null
        ? (json.decode(allTasksString) as List<dynamic>)
            .map((task) => Task.fromMap(task as Map<String, dynamic>))
            .toList()
        : [];

    List<Task> removedTasks = removedTasksString != null
        ? (json.decode(removedTasksString) as List<dynamic>)
            .map((task) => Task.fromMap(task as Map<String, dynamic>))
            .toList()
        : [];

    emit(TasksState(pendingTasks: allTasks, removedTasks: removedTasks));
  }

  Future<void> _saveTasks(TasksState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('all_tasks',
        json.encode(state.pendingTasks.map((task) => task.toMap()).toList()));
    await prefs.setString('removed_tasks',
        json.encode(state.removedTasks.map((task) => task.toMap()).toList()));
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final List<Task> newTasks = List<Task>.from(state.pendingTasks)
      ..add(event.task);

    emit(TasksState(
      pendingTasks: newTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));

    _saveTasks(state);
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final List<Task> pendingTasks = List<Task>.from(state.pendingTasks);
    final List<Task> completedTasks = List<Task>.from(state.completedTasks);

    if (event.task.isDone!) {
      completedTasks.remove(event.task);
      pendingTasks.insert(0, event.task.copyWith(isDone: false));
    } else {
      pendingTasks.remove(event.task);
      completedTasks.insert(0, event.task.copyWith(isDone: true));
    }

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));

    _saveTasks(state);
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final List<Task> newRemovedTasks = List<Task>.from(state.removedTasks)
      ..remove(event.task);

    emit(TasksState(
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: newRemovedTasks,
    ));

    _saveTasks(state);
  }

  void _onMarkFavoriteOrUnFavoriteTask(
      MarkFavoriteOrUnFavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favroiteTasks = state.favoriteTasks;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favroiteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favroiteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favroiteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favroiteTasks.remove(event.task);
      }
    }
    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favroiteTasks,
        removedTasks: state.removedTasks));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final List<Task> newPendingTasks = List<Task>.from(state.pendingTasks)
      ..remove(event.task);
    final List<Task> newRemovedTasks = List<Task>.from(state.removedTasks)
      ..add(event.task.copyWith(isDeleted: true));

    emit(TasksState(
      pendingTasks: newPendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: newRemovedTasks,
    ));

    _saveTasks(state);
  }

 void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
  final state = this.state;

  emit(TasksState(
    removedTasks: List.from(state.removedTasks)..remove(event.task),
    pendingTasks: List.from(state.pendingTasks)
      ..insert(
          0,
          event.task
              .copyWith(isDeleted: false, isDone: false, isFavorite: false)),
    completedTasks: state.completedTasks,
    favoriteTasks: state.favoriteTasks,
  ));
}

void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
  final state = this.state;

  emit(TasksState(
    removedTasks: List.from(state.removedTasks)..clear(),
    pendingTasks: state.pendingTasks,
    completedTasks: state.completedTasks,
    favoriteTasks: state.favoriteTasks,
  ));
}

}
