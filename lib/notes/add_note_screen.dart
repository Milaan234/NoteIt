import 'package:flutter/material.dart';
import 'package:notes_app/notes/methods.dart';
import 'package:notes_app/notes/notes_screen.dart';

// screen to add a new note
class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreen();
}

class _AddNoteScreen extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final _titleTextController = TextEditingController();
    final _contentTextController = TextEditingController();

    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: Text(
          'New Note',
          style: TextStyle(
            //fontSize: 28.0,
            fontWeight: FontWeight.w600
          )
        ),
        centerTitle: true,
        // button to go back to notes screen
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesScreen(),
            )
          );
          },
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleTextController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        // Optional
                        onSubmitted: (_) {
                          
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    // button to add the new note to database
                    IconButton(
                      onPressed: () {
                        setState(() {
                          addNote(titleTextController: _titleTextController, contentTextController: _contentTextController);
                          _titleTextController.clear();
                          _contentTextController.clear();
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotesScreen(),
                            )
                          );
                        });
                      }, 
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _contentTextController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  // Optional (runs when enter is pressed in the textbox)
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}