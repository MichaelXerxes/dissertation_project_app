import 'package:dissertation_project_app/core/enums/piority_level_enum.dart';
import 'package:equatable/equatable.dart';

class ToDoItem extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime dateTimeAdded;
  final PriorityLevelEnum priority;

  ToDoItem({
    required this.id,
    required this.title,
    required this.content,
    DateTime? dateTimeAdded,
    this.priority = PriorityLevelEnum.LOW,
  }) : dateTimeAdded = dateTimeAdded ?? DateTime.now();

  @override
  List<Object?> get props => [id, title, content, dateTimeAdded, priority];
}
