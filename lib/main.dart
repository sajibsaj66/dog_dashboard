import 'package:dog_dashboard/features/dog_dashboard/presentation/pages/dog_dashboard_page.dart';
import 'package:flutter/material.dart';
// import 'package:your_app/core/di/injection_container.dart'; // Import your dependency injection container.
// import 'package:your_app/presentation/app.dart'; // Import your main app widget.

void main() async {
  // Initialize your dependency injection container.
  // await init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Image App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogDashboardPage(), // Your main dashboard page.
    );
  }
}
