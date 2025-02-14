part of 'tasks_bloc.dart';

class TasksEvent extends Equatable {
  const TasksEvent();
  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  final Task task;
  AddTask({required this.task});
  List<Object> get props => [task];
}

class UpdateTask extends TasksEvent {
  final Task task;
  UpdateTask({required this.task});
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;
  DeleteTask({required this.task});
  List<Object> get props => [task];
}

class MarkFavoriteOrUnFavoriteTask extends TasksEvent {
  final Task task;
  MarkFavoriteOrUnFavoriteTask({required this.task});
  List<Object> get props => [task];
}

class RemoveTask extends TasksEvent {
  final Task task;
  RemoveTask({required this.task});
  List<Object> get props => [task];
}
