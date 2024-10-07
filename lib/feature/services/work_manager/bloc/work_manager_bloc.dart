import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dissertation_project_app/feature/services/work_manager/models/meeting_model.dart';
import 'package:dissertation_project_app/feature/services/work_manager/presentation/screens/work_manager_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'work_manager_event.dart';

part 'work_manager_state.dart';

class WorkManagerBloc extends Bloc<WorkManagerEvent, WorkManagerState> {
  WorkManagerBloc() : super(const WorkManagerInitial()) {
    on<AddMeetingEvent>(_onAddNewMeeting);
    on<MeetingRemoveEvent>(_oneMeetingRemove);
    on<DisplayMeetingEvent>((event, emit) {
      emit(WorkManagerLoaded(meetings: event.meetings));
    });
  }

  FutureOr<void> _onAddNewMeeting(
      AddMeetingEvent event, Emitter<WorkManagerState> emit) async {
    final newMeeting = Meeting(
      event.eventName,
      event.eventDescription,
      event.startDate,
      event.finishDate,
      event.background ?? Colors.green,
      event.isAllDay,
    );

    if (state is WorkManagerLoaded) {
      emit(state.copyWith(
        meetings: List.from(state.meetings)..add(newMeeting),
      ));

    } else {
      emit(WorkManagerLoaded(meetings: [newMeeting]));
    }
  }

  FutureOr<void> _oneMeetingRemove(
      MeetingRemoveEvent event, Emitter<WorkManagerState> emit) async {
    if (state is WorkManagerLoaded) {
      final currentMeetingList = List<Meeting>.from(state.meetings)
        ..remove(event.meeting);
      emit(state.copyWith(meetings: currentMeetingList));
    }
  }
}

