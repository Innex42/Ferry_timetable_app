import 'package:flutter/material.dart';

class SavedTimetablesPage extends StatefulWidget {
  const SavedTimetablesPage({super.key});

  @override
  State<SavedTimetablesPage> createState() => _SavedTimetablesPageState();
}

class _SavedTimetablesPageState extends State<SavedTimetablesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Saved Timetables"),
          centerTitle: true,
        ),
      );
}
