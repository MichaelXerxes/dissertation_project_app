import 'package:dissertation_project_app/core/main_utils/app_routes/app_routes.dart';
import 'package:dissertation_project_app/core/screens/load_app_data_screen.dart';
import 'package:dissertation_project_app/core/widgets/buttons/custom_floating_button/custom_floating_button.dart';
import 'package:dissertation_project_app/core/widgets/containers/animated_item_container/animated_item_container.dart';
import 'package:dissertation_project_app/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:dissertation_project_app/feature/services/work_manager/helpers/meeting_data_list_manager.dart';
import 'package:dissertation_project_app/feature/services/work_manager/models/meeting_model.dart';
import 'package:dissertation_project_app/feature/services/work_manager/presentation/widgets/work_manager_left_custom_button.dart';
import 'package:dissertation_project_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../widgets/work_manager_right_custom_button.dart';

class WorkManagerScreen extends StatefulWidget {
  const WorkManagerScreen({super.key});

  @override
  State<WorkManagerScreen> createState() => _WorkManagerScreenState();
}

class _WorkManagerScreenState extends State<WorkManagerScreen> {
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
      body: BlocBuilder<WorkManagerBloc, WorkManagerState>(
        builder: (context, state) {
          if (state is WorkManagerLoaded) {
            return SfCalendar(
              key: ValueKey(_calendarView),
              view: _calendarView,
              dataSource: MeetingDataListManager(state.meetings),
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
                                    Text(
                                        'Content: ${meeting.eventDescription}'),
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
            );
          } else {
            return const LoadAppDataScreen();
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
              onItemClicked: _onRightItemsClicked,
            ),
          ),
        ],
      ),
    );
  }
}
