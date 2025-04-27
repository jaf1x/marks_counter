import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/main_screen_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        // scaffoldBackgroundColor: const Color.fromARGB(221, 30, 30, 30),
        scaffoldBackgroundColor: const Color.fromARGB(221, 30, 30, 30)
      ),
      home: MainScreenWidget(),
    );
  }
}
