
import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() => runApp(StudyPilotApp());

class StudyPilotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyPilot',
      theme: ThemeData.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
