import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/boxes.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/notes/edit_note_screen.dart';
import 'package:notes_app/notes/note.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// stores all the notes methods

// makes a new note
void addNote({required TextEditingController titleTextController, required TextEditingController contentTextController}) {
  total_notes += 1;
  boxNotes.put(
    'key_${total_notes}', // stores the key for the note, *Very Important* in identification
    Note(
      title: titleTextController.text,
      content: contentTextController.text,
      createdAt: DateTime.now(),
      id: total_notes,
      updatedAt: DateTime.now(),
    )
  );
}

// updates note
void updateNote({required TextEditingController titleTextController, required TextEditingController contentTextController, required String indexKey}) {
  Note updatedNote = boxNotes.get(indexKey);
  boxNotes.get(indexKey).title = titleTextController.text;
  boxNotes.get(indexKey).content = contentTextController.text;
  boxNotes.get(indexKey).updatedAt = DateTime.now();
  updatedNote.save();
}

// deletes a note
void deleteNote(int id) {
  var keyValue = 'key_' + id.toString();
  boxNotes.delete(keyValue);
}

// deletes all notes
void deleteAllNotes(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete All Notes'),
      content: Text(
        'Are you sure you want to delete all your notes?'
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            boxNotes.clear();
            Navigator.pop(context);
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.red
            )
          ),
        ),
      ],
    )
  );
}

// displays the list of notes on the notes screen
Widget buildNotesList (BuildContext context) {
  // listenable makes sure that the display is updated if there are any updates (ex: checkbox clicked)
  return ValueListenableBuilder<Box>(
    valueListenable: boxNotes.listenable(),
    builder: (context, box, _) {
      // if there are no note items, displays no note items and tells user to add notes
      if (boxNotes.length == 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.note,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Your notes list is empty',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Add notes to get started',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ); 
      }

      // notes converted to list to sort them
      List notes = boxNotes.values.toList();
      notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      
      // shows if there are notes
      return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          // gets the note and assigns it to a variable
          Note note = notes[index];
          String indexKey = 'key_' + note.id.toString();

          // if the note does not have content (expanded view does not open)
          if (note.content == null || note.content!.isEmpty) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      Navigator.pop(context);
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(indexKey: indexKey),
                      )
                      );
                    },
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
              child: InkWell(
                child: Card(
                  child: ExpansionTile(
                    title: ListTile(
                      title: Text(
                        note.title,
                      ),
                      trailing: Text(
                        DateFormat('MMM d, yyyy').format(note.updatedAt),
                      ),
                    ),
                    trailing: SizedBox.shrink(),
                    //children: <Widget>[ListTile(title: Text(""))],
                  ),
                ),
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Note'),
                      content: Text(
                        'Are you sure you want to delete "${note.title}"?'
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteNote(note.id);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red
                            )
                          ),
                        ),
                      ],
                    )
                  );
                },
              )
            );
            
          }

          // if the note has content value (expanded view opens on tap)
          else {

            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      Navigator.pop(context);
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(indexKey: indexKey),
                      )
                      );
                    },
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
              child: InkWell(
                child: Card(
                  child: ExpansionTile(
                    title: ListTile(
                      title: Text(
                        note.title,
                      ),
                      trailing: Text(
                        DateFormat('MMM d, yyyy').format(note.updatedAt),
                      ),
                    ),
                    trailing: SizedBox.shrink(),
                    children: <Widget>[ListTile(title: Text(note.content!))],
                  )
                ),
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Note'),
                      content: Text(
                        'Are you sure you want to delete "${note.title}"?'
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteNote(note.id);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red
                            )
                          ),
                        ),
                      ],
                    )
                  );
                },
              )
            );
          }
          
        },
      );
    }
  );
    
}