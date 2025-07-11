import 'package:flutter/material.dart';
import 'package:notes_app/notes/add_note_screen.dart';
import 'package:notes_app/notes/methods.dart';
import 'package:notes_app/settings/settings_screen.dart';
import 'package:notes_app/tasks/tasks_screen.dart';

// notes screen, acts as the home screen
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreen();
}

class _NotesScreen extends State<NotesScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600
          )
        ),
        centerTitle: true,
        // button to go to settings screen
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              )
            );
          }
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.check_box),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TasksScreen(),
                )
              );
            }
          ),
        ],

      ),

      // body of the notes screen where all the notes appear
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Expanded(
              child: buildNotesList(context),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),

      // button to make a new note
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(),
            )
          );
        },
      ),
    );
  }
}