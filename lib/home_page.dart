import 'package:dissertation_project_app/core/tools/flutter_helper.dart';
import 'package:dissertation_project_app/core/widgets/bottom_bar.dart';
import 'package:dissertation_project_app/core/widgets/buttons/custom_floating_button/custom_floating_button.dart';
import 'package:dissertation_project_app/core/widgets/buttons/custom_side_button_menu/custom_side_button_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomSideButtonMenu(),
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: []),
      bottomNavigationBar: BottomBar(indexValue: 0),
    );
  }
}
