import 'package:equatable/equatable.dart';

class ToDoItem extends Equatable {
  final String id;
  final String title;

  const ToDoItem({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
