// import 'package:dissertation_project_app/bloc/counter_bloc.dart';
// import 'package:dissertation_project_app/cubit/counter_cubit.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text("Hello World Home Page"),
            CustomSideButtonMenu(),
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: 'fab_increment',
          onPressed: () => {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'fab_decrement',
          onPressed: () => {},
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
        const SizedBox(height: 8),
      ]),
      bottomNavigationBar: BottomBar(indexValue: 1),
    );
  }
}
