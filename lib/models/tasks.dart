import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String id;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;
  Task({
    required this.title,
    required this.description,
    required this.id,
    required this.date,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }
  Task copyWith(
      {String? date,
      String? id,
      String? title,
      bool? isDone,
      bool? isDeleted,
      bool? isFavorite}) {
    return Task(
        id: id ?? this.id,
        date: date ?? this.date,
        title: title ?? this.title,
        description: title ?? this.description,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted,
        isFavorite: isFavorite ?? this.isFavorite);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      date: map['date'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDOne'] ?? '',
      isDeleted: map['isDeleted'] ?? '',
      isFavorite: map['isFavorite'] ?? '',
    );
  }

  @override
  List<Object?> get props =>
      [id, date, title, description, isDone, isDeleted, isFavorite];
}
