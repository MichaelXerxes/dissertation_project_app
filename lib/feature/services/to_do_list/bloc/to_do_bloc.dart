import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:equatable/equatable.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  late Timer _expirationCheckTimer;
  ToDoBloc() : super(ToDoInitial()) {
    on<AddToDoListItem>(_onAddToDoListItem);
    on<RemoveToDoListItem>(_onRemoveToDoListItem);
    on<UpdateToDoList>(_onUpdateToDoList);

    _expirationCheckTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkForExpiredItems();
    });
  }

  final List<ToDoItem> _todos = [];

  FutureOr<void> _onAddToDoListItem(
      AddToDoListItem event, Emitter<ToDoState> emit) {
    _todos.add(event.todo);
    emit(ToDoLoadSuccess(todos: List.from(_todos)));
  }

  FutureOr<void> _onRemoveToDoListItem(
      RemoveToDoListItem event, Emitter<ToDoState> emit) {
    _todos.removeWhere((todo) => todo.id == event.id);
    emit(ToDoLoadSuccess(todos: List.from(_todos)));
  }

  FutureOr<void> _onUpdateToDoList(
      UpdateToDoList event, Emitter<ToDoState> emit) {
    final index = _todos.indexWhere((todo) => todo.id == event.todo.id);

    if (index != -1) {
      _todos[index] = event.todo;
      emit(ToDoLoadSuccess(todos: List.from(_todos)));
    }
  }

  FutureOr<void> _checkForExpiredItems() {
    final now = DateTime.now();
    _todos.removeWhere((todo) => todo.expiredDate.isBefore(now));

    emit(ToDoLoadSuccess(todos: List.from(_todos)));
  }
}
