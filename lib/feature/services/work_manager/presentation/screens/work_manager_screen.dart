import 'package:dissertation_project_app/core/main_utils/app_routes/app_routes.dart';
import 'package:dissertation_project_app/core/widgets/buttons/custom_floating_button/custom_floating_button.dart';
import 'package:dissertation_project_app/core/widgets/containers/animated_item_container/animated_item_container.dart';
import 'package:dissertation_project_app/feature/services/work_manager/presentation/widgets/work_manager_left_custom_button.dart';
import 'package:dissertation_project_app/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../widgets/work_manager_right_custom_button.dart';

class WorkManager extends StatefulWidget {
  const WorkManager({super.key});

  @override
  State<WorkManager> createState() => _WorkManagerState();
}

class _WorkManagerState extends State<WorkManager> {
  CalendarView _calendarView = CalendarView.day;
  bool toggleButton = true;


  void _onLeftItemsClicked(int index) {
    switch (index) {
      case 0:
        setState(() {
          _calendarView = CalendarView.day;
        });
        break;
      case 1:
        setState(() {
          _calendarView = CalendarView.week;
        });
        break;
      case 2:
        setState(() {
          _calendarView = CalendarView.month;
        });
        break;
      default:
        print("Unknown icon tapped");
    }
  }

  void _onRightItemsClicked(int index) {
    switch (index) {
      case 0:
        MainApp.navigatorKey.currentState!
            .pushNamed(AppRoutes.addNewEventScreen);
        break;
      case 1:
        setState(() {
          _calendarView = CalendarView.week;
        });
        break;
      case 2:
        setState(() {
          _calendarView = CalendarView.month;
        });
        break;
      default:
        print("Unknown icon tapped");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Manager'),
      ),
      body: SfCalendar(
        key: ValueKey(_calendarView),
        view: _calendarView,
        dataSource: MeetingDataSource(_getDataSource()),
        // weekViewSettings: const WeekViewSettings(),

        onTap: (CalendarTapDetails details) {
          if (details.appointments != null &&
              details.appointments!.isNotEmpty) {
            final List<Meeting> meetings =
                details.appointments!.cast<Meeting>();

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Meeting Details'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: meetings.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Meeting meeting = meetings[index];
                        return ListTile(
                          title: Text(meeting.eventName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('From: ${meeting.from}'),
                              Text('To: ${meeting.to}'),
                              Text(
                                  'All Day: ${meeting.isAllDay ? 'Yes' : 'No'}'),
                              Text('Content: ${meeting.eventDescription}'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            left: 20,
            child:
                WorkManagerLeftCustomButton(onItemCliked: _onLeftItemsClicked),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            child: WorkManagerRightCustomButton(
                onItemClicked: _onRightItemsClicked),
          ),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    final DateTime startTime2 = DateTime(today.year, today.month, today.day, 1);
    final DateTime endTime2 = startTime.add(const Duration(hours: 5));
    meetings.add(Meeting('Conference', "some random text messeage 111",
        startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting('Conference', "some random text messeage 222",
        startTime2, endTime2, const Color(0xFF0F8644), false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  String eventName;
  String eventDescription;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  Meeting(this.eventName, this.eventDescription, this.from, this.to,
      this.background, this.isAllDay);
}
