import 'package:flutter/material.dart';
import 'package:notes_app/boxes.dart';
import 'package:notes_app/notes/methods.dart';
import 'package:notes_app/notes/notes_screen.dart';

// screen that opens when user edits a note
class EditNoteScreen extends StatefulWidget {
  final String indexKey;

  // asks for note index key (string) when the screen is opened
  const EditNoteScreen({super.key, required this.indexKey});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreen();
}

class _EditNoteScreen extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    // gives the textboxes the note's existing values
    late final _titleTextController = TextEditingController();
    _titleTextController.text = boxNotes.get(widget.indexKey).title;
    late final _contentTextController = TextEditingController();
    _contentTextController.text = boxNotes.get(widget.indexKey).content;

    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: Text(
          'Edit Note',
          style: TextStyle(
            //fontSize: 28.0,
            fontWeight: FontWeight.w600
          )
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {

            // button to go back to notes screen
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Discard Changes'),
                content: Text(
                  'Are you sure you want to discard changes"?'
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotesScreen(),
                        )
                      );
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.red
                      )  
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No',),
                  ),
                ],
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
                    // button to save changes to the note
                    IconButton(
                      onPressed: () {
                        setState(() {
                          updateNote(titleTextController: _titleTextController, contentTextController: _contentTextController, indexKey: widget.indexKey);
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
                      icon: const Icon(Icons.check),
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
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}