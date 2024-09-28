import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  // Add other fields as necessary

  const User({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
