import 'package:flutter/material.dart';

class LoadAppDataScreen extends StatelessWidget {
  const LoadAppDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Data'),
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(color: Colors.green),
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                minHeight: 10.0,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'Loading data, please wait...',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
