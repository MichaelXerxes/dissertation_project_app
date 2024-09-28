import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dissertation_project_app/core/models/to_do_item/to_do_item_model.dart';
import 'package:equatable/equatable.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoInitial()) {
    on<AddToDo>(_onAddToDo);
    on<RemoveToDo>(_onRemoveToDo);
  }

  final List<ToDoItem> _todos = [];

  FutureOr<void> _onAddToDo(AddToDo event, Emitter<ToDoState> emit) {
    _todos.add(event.todo);
    emit(ToDoLoadSuccess(todos: List.from(_todos)));
  }

  FutureOr<void> _onRemoveToDo(RemoveToDo event, Emitter<ToDoState> emit) {
    _todos.removeWhere((todo) => todo.id == event.id);
    emit(ToDoLoadSuccess(todos: List.from(_todos)));
  }
}
