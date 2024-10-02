import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dissertation_project_app/core/enums/piority_level_enum.dart';
import 'package:dissertation_project_app/core/helpers/local_notification_helper.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:equatable/equatable.dart';

part 'to_do_event.dart';

part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoInitial()) {
    on<AddToDoListItem>(_onAddToDoListItem);
    on<RemoveToDoListItem>(_onRemoveToDoListItem);
    on<UpdateToDoList>(_onUpdateToDoList);
    on<CheckForExpiredItems>(_checkForExpiredItems);
  }

  final List<ToDoItem> _toDoList = [];

  FutureOr<void> _onAddToDoListItem(
      AddToDoListItem event, Emitter<ToDoState> emit) {
    _toDoList.add(event.todo);
    emit(ToDoLoadSuccess(todos: List.from(_toDoList)));
  }

  FutureOr<void> _onRemoveToDoListItem(
      RemoveToDoListItem event, Emitter<ToDoState> emit) {
    _toDoList.removeWhere((todo) => todo.id == event.id);
    NotificationHelper.cancelNotification(event.id.hashCode);
    emit(ToDoLoadSuccess(todos: List.from(_toDoList)));
  }

  FutureOr<void> _onUpdateToDoList(
      UpdateToDoList event, Emitter<ToDoState> emit) {
    final index = _toDoList.indexWhere((todo) => todo.id == event.todo.id);

    if (index != -1) {
      _toDoList[index] = event.todo;
      emit(ToDoLoadSuccess(todos: List.from(_toDoList)));
    }
  }

  FutureOr<void> _checkForExpiredItems(
      CheckForExpiredItems event, Emitter<ToDoState> emit) {
    final now = DateTime.now();
    _toDoList.removeWhere((todo) => todo.expiredDate.isBefore(now));
    _notificationAlertListGenerator(_toDoList);
    emit(ToDoLoadSuccess(todos: List.from(_toDoList)));
  }

  void _notificationAlertListGenerator(List<ToDoItem> toDoList) {
    final now = DateTime.now();
    List<ToDoItem> tasksBetweenOneAndThreeDaysLeft = [];
    List<ToDoItem> tasksWithLessThan24HoursLeft = [];

    for (var item in toDoList) {
      final difference = item.expiredDate.difference(now);
      if (item.priority == PriorityLevelEnum.MEDIUM ||
          item.priority == PriorityLevelEnum.HIGH) {
        if (difference.inHours >= 24 && difference.inHours < 72) {
          tasksBetweenOneAndThreeDaysLeft.add(item);
        } else if (difference.inHours < 24) {
          tasksWithLessThan24HoursLeft.add(item);
        }
      }
    }

    if (tasksBetweenOneAndThreeDaysLeft.isNotEmpty) {
      final tasksSummary = _notificationTasksSummary(
          tasksBetweenOneAndThreeDaysLeft, tasksWithLessThan24HoursLeft);
      NotificationHelper.scheduleNotification(
        id: 1,
        title: 'Tasks due in less than 3 days',
        body: tasksSummary,
        scheduledDate: DateTime.now().add(Duration(seconds: 5)),
      );
    }

    if (tasksWithLessThan24HoursLeft.isNotEmpty) {
      final body = _notificationTasksSummary(
          tasksWithLessThan24HoursLeft, tasksWithLessThan24HoursLeft);
      NotificationHelper.scheduleNotification(
        id: 2,
        title: 'Urgent! Tasks due in less than 24 hours',
        body: body,
        scheduledDate: DateTime.now().add(Duration(seconds: 5)),
      );
    }
  }

  String _notificationTasksSummary(
      List<ToDoItem> highPriorityTasks, List<ToDoItem> mediumPriorityTasks) {
    final StringBuffer stringBuffer = StringBuffer();
    bool hasHighPriority = highPriorityTasks
        .any((task) => task.priority == PriorityLevelEnum.HIGH);
    bool hasMediumPriority = mediumPriorityTasks
        .any((task) => task.priority == PriorityLevelEnum.MEDIUM);

    if (hasHighPriority) {
      stringBuffer.writeln("*** Priority - Medium ***");
      for (var task in highPriorityTasks) {
        if (task.priority == PriorityLevelEnum.HIGH) {
          stringBuffer.writeln(
              '- ${task.title}: Due in ${task.expiredDate.difference(DateTime.now()).inHours} hours');
        }
      }
    }

    if (hasMediumPriority) {
      stringBuffer.writeln("*** Priority - Medium ***");
      for (var task in mediumPriorityTasks) {
        if (task.priority == PriorityLevelEnum.MEDIUM) {
          stringBuffer.writeln(
              '- ${task.title}: Due in ${task.expiredDate.difference(DateTime.now()).inHours} hours');
        }
      }
    }

    return stringBuffer.toString();
  }
}
