import 'package:flutter/material.dart';

class LoadAppDataScreen extends StatelessWidget {
  const LoadAppDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Progress bar
            SizedBox(height: 20), // Spacing between progress bar and text
            Text('Loading, please wait...', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
