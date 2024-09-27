import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.title, required this.indexValue});

  final String title;
  final int indexValue;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'To-Do List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.stop),
          label: "To-Do Page",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Sign In',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: 'Weather',
        ),
      ],
      currentIndex: widget.indexValue,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.red,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(
              context,
              '/to_do_list_app/todo_list',
            );
            break;

          case 1:
            Navigator.pushNamed(
              context,
              '/to_do_list_app/add_todo_page',
            );
            break;
          case 2:
            Navigator.pushNamed(
              context,
              '/home_page',
            );
            break;
          case 3:
            Navigator.pushNamed(
              context,
              '/sign_in_app/login_page',
            );
            break;
          case 4:
            Navigator.pushNamed(
              context,
              '/weather_app/weather_page',
            );
            break;
        }
      },
    );
  }
}
