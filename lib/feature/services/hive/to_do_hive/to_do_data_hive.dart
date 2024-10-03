import 'package:dissertation_project_app/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';
import 'package:dissertation_project_app/core/enums/piority_level_enum.dart';
import 'package:equatable/equatable.dart';

part 'to_do_data_hive.g.dart';

@HiveType(typeId: HiveProperties.toDoListID)
class ToDoItemHive extends Equatable {
  @HiveField(HiveToDoListProperties.id)
  final String id;

  @HiveField(HiveToDoListProperties.title)
  final String title;

  @HiveField(HiveToDoListProperties.content)
  final String content;

  @HiveField(HiveToDoListProperties.dateTimeAdded)
  final DateTime dateTimeAdded;

  @HiveField(HiveToDoListProperties.expiredDate)
  final DateTime expiredDate;

  // Store priority as a String
  @HiveField(HiveToDoListProperties.priority)
  final String priority;

  // Constructor that allows setting the priority as a String or from enum
  ToDoItemHive({
    required this.id,
    required this.title,
    required this.content,
    DateTime? dateTimeAdded,
    DateTime? expiredDate,
    String? priority, // default priority as String
  })  : dateTimeAdded = dateTimeAdded ?? DateTime.now(),
        expiredDate = expiredDate ?? DateTime.now().add(const Duration(days: 60)),
        priority = priority ?? PriorityLevelEnum.LOW.toString().split('.').last;

  // Helper to convert String back to PriorityLevelEnum
  PriorityLevelEnum get priorityEnum => PriorityLevelEnum.values.firstWhere(
          (e) => e.toString().split('.').last == priority,
      orElse: () => PriorityLevelEnum.LOW);

  @override
  List<Object?> get props =>
      [id, title, content, dateTimeAdded, expiredDate, priority];
}
