import 'package:flutter/material.dart';
import 'package:notes_app/notes/notes_screen.dart';
import 'package:notes_app/settings/settings_screen.dart';
import 'package:notes_app/tasks/methods.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreen();
}

class _TasksScreen extends State<TasksScreen> {

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Tasks",
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
            icon: const Icon(Icons.note),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesScreen(),
                )
              );
            }
          ),
        ],

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
                        controller: _textController,
                        decoration: const InputDecoration(
                          labelText: 'Add Task',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) {
                          setState(() {
                          addTask(titleTextController: _textController);
                          _textController.clear();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        
                        setState(() {
                          addTask(titleTextController: _textController);
                          _textController.clear();
                        });
                        
                      }, 
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                
              ],
            ),
          ),

          // display area for tasks
          Expanded(
            child: buildTasksList(context),
          ),

        ],
      ),
    );

  }
}