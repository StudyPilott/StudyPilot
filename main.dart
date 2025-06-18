import 'package:flutter/material.dart';
import 'screens/planner.dart';
import 'screens/timer.dart';
import 'screens/calendar.dart';
import 'screens/study_room.dart';
import 'screens/tracker.dart';

void main() {
  runApp(StudyPilotApp());
}

class StudyPilotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyPilot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StudyPilot")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Planner"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PlannerScreen())),
          ),
          ListTile(
            title: Text("Pomodoro Timer"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TimerScreen())),
          ),
          ListTile(
            title: Text("Exam Calendar"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CalendarScreen())),
          ),
          ListTile(
            title: Text("Group Study Room"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudyRoomScreen())),
          ),
          ListTile(
            title: Text("Syllabus Tracker"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TrackerScreen())),
          ),
        ],
      ),
    );
  }
}
