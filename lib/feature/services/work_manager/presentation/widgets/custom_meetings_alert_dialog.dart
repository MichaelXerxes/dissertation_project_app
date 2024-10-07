import 'package:flutter/material.dart';
import 'package:dissertation_project_app/feature/services/work_manager/models/meeting_model.dart';

class CustomMeetingsAlertDialog extends StatelessWidget {
  final List<Meeting> meetings;

  const CustomMeetingsAlertDialog({super.key, required this.meetings});

  @override
  Widget build(BuildContext context) {
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
                  Text('From: ${meeting.startDate}'),
                  Text('To: ${meeting.finishDate}'),
                  Text('All Day: ${meeting.isAllDay ? 'Yes' : 'No'}'),
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
  }
}
