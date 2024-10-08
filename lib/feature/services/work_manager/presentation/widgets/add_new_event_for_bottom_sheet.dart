import 'package:dissertation_project_app/core/tools/constants.dart';
import 'package:dissertation_project_app/feature/services/work_manager/presentation/widgets/color_selector.dart';
import 'package:dissertation_project_app/feature/services/work_manager/presentation/widgets/custom_dropdown_hours.dart';
import 'package:flutter/material.dart';

class AddNewEventForBottomSheet extends StatelessWidget {
  final bool isLastDateVisible;
  final GlobalKey<FormState> formKey;
  TextEditingController? controllerName;
  TextEditingController? controllerDescription;
  DateTime? fromSelectedDate;
  DateTime? toSelectedDate;
  TimeOfDay? fromSelectedTime;
  TimeOfDay? toSelectedTime;
  Future<void> Function()? selectFromDateTime;
  Future<void> Function()? selectToDateTime;
  final Function(Color color) onColorSelected;
  final Color selectedColor;
  bool isAllDay;
  Function() addMeeting;
  int eventDurationPerDay;
  Function(int index) onEventDurationPerDay;
  Function(bool isAllDay) onAllDay;

  AddNewEventForBottomSheet({
    super.key,
    required this.isLastDateVisible,
    required this.formKey,
    this.controllerName,
    this.controllerDescription,
    this.fromSelectedDate,
    this.fromSelectedTime,
    this.toSelectedDate,
    this.toSelectedTime,
    this.selectFromDateTime,
    this.selectToDateTime,
    required this.selectedColor,
    required this.onColorSelected,
    required this.isAllDay,
    required this.addMeeting,
    required this.eventDurationPerDay,
    required this.onEventDurationPerDay,
    required this.onAllDay,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true, // Add this line
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: 16),
              Text('Add New Event'),
              const SizedBox(height: 16),
              TextFormField(
                controller: controllerName,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
                maxLength: Constants.MAX_LENGHT_TEXT_TITLE,
              ),
              TextFormField(
                controller: controllerDescription,
                decoration: const InputDecoration(
                  labelText: 'Event Description',
                ),
                maxLength: Constants.MAX_LENGHT_TEXT_CONTENT,
                maxLines: null,
              ),
              const SizedBox(height: 16),
              if (isLastDateVisible) ...[
                ListTile(
                  title: const Text('From'),
                  subtitle: Text(fromSelectedDate != null &&
                          fromSelectedTime != null
                      ? '${fromSelectedDate!.toLocal().toString().split(' ')[0]} ${fromSelectedTime!.format(context)}'
                      : 'Select Start Date & Time'),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: selectFromDateTime,
                  ),
                ),
                ListTile(
                  title: const Text('To'),
                  subtitle: Text(toSelectedDate != null &&
                          toSelectedTime != null
                      ? '${toSelectedDate!.toLocal().toString().split(' ')[0]} ${toSelectedTime!.format(context)}'
                      : 'Select End Date & Time'),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: selectToDateTime,
                  ),
                ),
              ] else ...[
                Text(fromSelectedDate != null &&
                        fromSelectedTime != null
                    ? '${fromSelectedDate!.toLocal().toString().split(' ')[0]} ${fromSelectedTime!.format(context)}'
                    : 'Select Start Date & Time'),
              ],
              const SizedBox(height: 16),
              CustomDropDownHours(
                  value: eventDurationPerDay,
                  selectedHours: onEventDurationPerDay
                  //     (selectedHours) {
                  //   setState(() {
                  //     widget.eventDurationPerDay = selectedHours;
                  //   });
                  // },
                  ),
              const SizedBox(height: 16),
              ColorSelector(
                initialColor: selectedColor,
                onColorSelected: onColorSelected,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('All Day Event'),
                value: isAllDay,
                onChanged:onAllDay
                //     (bool value) {
                //   setState(() {
                //     widget.isAllDay = value;
                //   });
                // },
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: addMeeting,
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
