
// StudyPilot Full Code (v1.4) — With Planner, Pomodoro, Dark Mode, Syllabus Tracker

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StudyPilotApp());
}

class StudyPilotApp extends StatefulWidget {
  const StudyPilotApp({super.key});
  @override
  State<StudyPilotApp> createState() => _StudyPilotAppState();
}

class _StudyPilotAppState extends State<StudyPilotApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyPilot',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: AuthScreen(toggleTheme: () => setState(() => isDark = !isDark)),
    );
  }
}

class AuthScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  const AuthScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signInAnonymously();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
              },
              child: const Text("Enter StudyPilot (Anonymous Login)"),
            ),
            IconButton(onPressed: toggleTheme, icon: const Icon(Icons.brightness_6))
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("StudyPilot")),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudyPlannerScreen())), child: const Text("Study Planner")),
        ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PomodoroTimerScreen())), child: const Text("Pomodoro Timer")),
        ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SyllabusTrackerScreen())), child: const Text("Exam Syllabus Tracker")),
      ],
    ),
  );
}

class StudyPlannerScreen extends StatelessWidget {
  const StudyPlannerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final topicController = TextEditingController();
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'anon';
    return Scaffold(
      appBar: AppBar(title: const Text("Study Planner")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: topicController, decoration: const InputDecoration(labelText: "Topic/Target")),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection("planner").add({
                'uid': uid,
                'task': topicController.text,
                'done': false,
              });
              topicController.clear();
            },
            child: const Text("Add Task"),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("planner").where("uid", isEqualTo: uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final docs = snapshot.data!.docs;
                return ListView(
                  children: docs.map((doc) => CheckboxListTile(
                    value: doc['done'],
                    title: Text(doc['task']),
                    onChanged: (val) {
                      FirebaseFirestore.instance.collection("planner").doc(doc.id).update({ 'done': val });
                    },
                  )).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class PomodoroTimerScreen extends StatefulWidget {
  const PomodoroTimerScreen({super.key});
  @override
  State<PomodoroTimerScreen> createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {
  int seconds = 1500;
  bool running = false;
  late final ticker = Ticker(_tick);

  void _tick(Duration d) {
    if (seconds == 0) return;
    setState(() => seconds--);
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(title: const Text("Pomodoro Timer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$min:$sec", style: const TextStyle(fontSize: 60)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() => running = !running);
                if (running) ticker.start(); else ticker.stop();
              },
              child: Text(running ? "Pause" : "Start"),
            )
          ],
        ),
      ),
    );
  }
}

class SyllabusTrackerScreen extends StatelessWidget {
  const SyllabusTrackerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'anon';
    return Scaffold(
      appBar: AppBar(title: const Text("Syllabus Tracker")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: controller, decoration: const InputDecoration(labelText: "Syllabus Topic")),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection("syllabus").add({
                'uid': uid,
                'topic': controller.text,
                'done': false
              });
              controller.clear();
            },
            child: const Text("Add"),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("syllabus").where("uid", isEqualTo: uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final docs = snapshot.data!.docs;
                return ListView(
                  children: docs.map((doc) => CheckboxListTile(
                    value: doc['done'],
                    title: Text(doc['topic']),
                    onChanged: (val) {
                      FirebaseFirestore.instance.collection("syllabus").doc(doc.id).update({'done': val});
                    },
                  )).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
