part of 'work_manager_bloc.dart';

sealed class WorkManagerEvent extends Equatable {
  const WorkManagerEvent();
}
class AddMeetingEvent extends WorkManagerEvent {
  final String eventName;
  final String eventDescription;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;

  const AddMeetingEvent({
    required this.eventName,
    required this.eventDescription,
    required this.from,
    required this.to,
    required this.isAllDay,
  });

  @override
  List<Object> get props => [eventName, eventDescription, from, to, isAllDay];
}