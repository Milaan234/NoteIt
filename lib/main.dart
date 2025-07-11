import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/boxes.dart';
import 'package:notes_app/notes/note.dart';
import 'package:notes_app/notes/notes_screen.dart';
import 'package:notes_app/tasks/task.dart';

// Acts as the ID for the notes and tasks
late int total_notes;
late int total_tasks;

void main() async {

  // Hive for notes
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  boxNotes = await Hive.openBox<Note>('noteBox');

  int current_notes_amount = boxNotes.length;
  total_notes = current_notes_amount;

  // Hive for tasks
  Hive.registerAdapter(TaskAdapter());
  boxTasks = await Hive.openBox<Task>('taskBox');

  int current_tasks_amount = boxTasks.length;
  total_tasks = current_tasks_amount;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
      ),

      // Opens Notes screen when app starts
      home: const NotesScreen(),
    );
  }
}