part of 'work_manager_bloc.dart';

sealed class WorkManagerState extends Equatable {
  const WorkManagerState();
}

final class WorkManagerInitial extends WorkManagerState {
  @override
  List<Object> get props => [];
}
