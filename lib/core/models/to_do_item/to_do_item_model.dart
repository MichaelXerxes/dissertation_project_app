import 'package:dissertation_project_app/core/enums/piority_level.dart';
import 'package:equatable/equatable.dart';

class ToDoItem extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime dateTimeAdded;
  final PriorityLevel priority;

  ToDoItem({
    required this.id,
    required this.title,
    required this.content,
    DateTime? dateTimeAdded,
    this.priority = PriorityLevel.LOW,
  }) : dateTimeAdded = dateTimeAdded ?? DateTime.now();

  @override
  List<Object?> get props => [id, title, content, dateTimeAdded, priority];
}
