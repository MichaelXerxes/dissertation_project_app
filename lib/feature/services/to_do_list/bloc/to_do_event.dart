part of 'to_do_bloc.dart';

// Events
abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object?> get props => [];
}

class AddToDo extends ToDoEvent {
  final ToDoItem todo;

  const AddToDo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class RemoveToDo extends ToDoEvent {
  final String id;

  const RemoveToDo({required this.id});

  @override
  List<Object?> get props => [id];
}
