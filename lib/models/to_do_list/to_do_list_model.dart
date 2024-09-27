import 'package:equatable/equatable.dart';

class ToDoList extends Equatable {
  final String id;
  final String title;

  const ToDoList({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
