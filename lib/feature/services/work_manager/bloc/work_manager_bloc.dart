import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dissertation_project_app/core/storage_hive/hive_properites.dart';
import 'package:dissertation_project_app/feature/services/work_manager/data/hive/work_manager_hive.dart';
import 'package:dissertation_project_app/feature/services/work_manager/models/meeting_model.dart';
import 'package:dissertation_project_app/feature/services/work_manager/presentation/screens/work_manager_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'work_manager_event.dart';

part 'work_manager_state.dart';

class WorkManagerBloc extends Bloc<WorkManagerEvent, WorkManagerState> {
  WorkManagerBloc() : super(const WorkManagerInitial()) {
    on<AddMeetingEvent>(_onAddNewMeeting);
    on<MeetingRemoveEvent>(_oneMeetingRemove);
    on<DisplayMeetingEvent>(_onDisplayEvents);
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

    print('Reached _onAddNewMeeting');
    print('Adding new meeting: $newMeeting');

    Box box = await Hive.openBox(HiveWorkManagerProperties.TO_WORK_MANAGER_DATA_BOX);
    List<dynamic>? getExistingHiveData = box.get(HiveWorkManagerProperties.TO_WORK_MANAGER_DATA_KEY);

    List<WorkManagerHive> toDoNewList = [];

    if (getExistingHiveData != null) {
      toDoNewList = getExistingHiveData.cast<WorkManagerHive>();
      print('Retrieved existing data from Hive: $toDoNewList');
    }
    if (state is WorkManagerLoaded) {
      emit(state.copyWith(
        meetings: List.from(state.meetings)..add(newMeeting),
      ));
      final updatedHiveList = state.meetings
          .map((meeting) => WorkManagerHive(
          eventName: meeting.eventName,
          eventDescription: meeting.eventDescription,
          startDate: meeting.startDate,
          finishDate: meeting.finishDate,
          backgroundColor: meeting.backgroundColor,
          isAllDay: meeting.isAllDay))
          .toList();

      await box.put(HiveWorkManagerProperties.TO_WORK_MANAGER_DATA_KEY, updatedHiveList);
      print('Updated data stored in Hive: $updatedHiveList');
    } else {
      emit(WorkManagerLoaded(meetings: [newMeeting]));
      final updatedHiveList = [
        WorkManagerHive(
          eventName: newMeeting.eventName,
          eventDescription: newMeeting.eventDescription,
          startDate: newMeeting.startDate,
          finishDate: newMeeting.finishDate,
          backgroundColor: newMeeting.backgroundColor,
          isAllDay: newMeeting.isAllDay,
        )
      ];
      await box.put(HiveWorkManagerProperties.TO_WORK_MANAGER_DATA_KEY, updatedHiveList);
      print('New meeting stored in Hive: $updatedHiveList');
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

  FutureOr<void> _onDisplayEvents(
      DisplayMeetingEvent event, Emitter<WorkManagerState> emit) async {
    print('Reached _onDisplayEvents');
    Box box = await Hive.openBox(HiveWorkManagerProperties.TO_WORK_MANAGER_DATA_BOX);


    List<dynamic>? getExistingHiveData = box.get(HiveWorkManagerProperties.TO_WORK_MANAGER_DATA_KEY);


    List<Meeting> meetingsFromHive = [];

    if (getExistingHiveData == null || getExistingHiveData.isEmpty) {
      print('No data in Hive to display.');
      return;
    }

    if (getExistingHiveData != null) {
      List<WorkManagerHive> hiveDataList = getExistingHiveData.cast<WorkManagerHive>();

      print('Retrieved data from Hive: $hiveDataList');
      meetingsFromHive = hiveDataList.map((hiveItem) {
        return Meeting(
          hiveItem.eventName,
          hiveItem.eventDescription,
          hiveItem.startDate,
          hiveItem.finishDate,
          hiveItem.backgroundColor,
          hiveItem.isAllDay,
        );
      }).toList();
    }

    print('Loaded meetings from Hive: $meetingsFromHive');
    emit(WorkManagerLoaded(meetings: meetingsFromHive));
  }

}
