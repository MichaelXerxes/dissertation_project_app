import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'work_manager_event.dart';
part 'work_manager_state.dart';

class WorkManagerBloc extends Bloc<WorkManagerEvent, WorkManagerState> {
  WorkManagerBloc() : super(WorkManagerInitial()) {
    on<WorkManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
