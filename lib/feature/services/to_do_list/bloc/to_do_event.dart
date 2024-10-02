part of 'to_do_bloc.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object?> get props => [];
}

class AddToDoListItem extends ToDoEvent {
  final ToDoItem todo;

  const AddToDoListItem({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class RemoveToDoListItem extends ToDoEvent {
  final String id;

  const RemoveToDoListItem({required this.id});

  @override
  List<Object?> get props => [id];
}

class CheckForExpiredItems extends ToDoEvent {
  //final String id;{required this.id}

  const CheckForExpiredItems();

  @override
  List<Object?> get props => [];
}

class UpdateToDoList extends ToDoEvent {
  final ToDoItem todo;

  const UpdateToDoList({required this.todo});

  @override
  List<Object?> get props => [todo];
}

// class CheckForExpiredItems extends ToDoEvent {
//   const CheckForExpiredItems();
//
//   @override
//   List<Object?> get props => [];
// }
