import 'package:flutter/material.dart';
import 'package:notes_app/notes/methods.dart';
import 'package:notes_app/notes/notes_screen.dart';

// settings screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            //fontSize: 28.0,
            fontWeight: FontWeight.w600
          )
        ),
        centerTitle: true,

        // goes back to the notes screen
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesScreen(),
            )
            );
          },
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            // settings option of deleting all notes
            child: Row(
              children: [
                Text(
                  'Delete all notes',
                  style: TextStyle(
                  fontSize: 18,
                ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red
                  ),
                  onPressed: () { deleteAllNotes(context); },
                )
              ],
            ),
          ),

        ],
      )
    );
  }
}