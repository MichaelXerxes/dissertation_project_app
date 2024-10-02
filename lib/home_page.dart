import 'package:dissertation_project_app/core/widgets/bottom_bar.dart';

import 'package:dissertation_project_app/core/widgets/buttons/custom_side_button_menu/custom_side_button_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await Permission.notification.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/space2.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            CustomSideButtonMenu(),

            ],
          ),
        ),
      ]),
      floatingActionButton:
          const Column(mainAxisAlignment: MainAxisAlignment.end, children: []),
      bottomNavigationBar: const BottomBar(indexValue: 0),
    );
  }
}
