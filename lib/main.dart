import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/boxes.dart';
import 'package:notes_app/notes/note.dart';
import 'package:notes_app/notes/notes_screen.dart';

// Acts as the ID for the notes
late int total_notes;

void main() async {

  // Hive for notes
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  boxNotes = await Hive.openBox<Note>('noteBox');

  int current_notes_amount = boxNotes.length;
  total_notes = current_notes_amount;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
      ),

      // Opens Notes screen when app starts
      home: const NotesScreen(),
    );
  }
}