import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/boxes.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/tasks/task.dart';

// makes a new task
void addTask({required TextEditingController titleTextController}) {
  total_tasks += 1;
  boxTasks.put(
    'key_${total_tasks}', // stores the key for the task, *Very Important* in identification
    Task(
      title: titleTextController.text,
      createdAt: DateTime.now(),
      id: total_tasks,
      isChecked: false,
    )
  );
}

// deletes a task
void deleteTask(int id) {
  var keyValue = 'key_' + id.toString();
  boxTasks.delete(keyValue);
}

// deletes all tasks
void deleteAllTasks(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete All Tasks'),
      content: Text(
        'Are you sure you want to delete all your tasks?'
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
            boxTasks.clear();
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


// displays the list of tasks on the tasks screen
Widget buildTasksList (BuildContext context) {
  // listenable makes sure that the display is updated if there are any updates (ex: checkbox clicked)
  return ValueListenableBuilder<Box>(
    valueListenable: boxTasks.listenable(),
    builder: (context, box, _) {
      // if there are no task items, displays no task items and tells user to add tasks
      if (boxTasks.length == 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_box,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Your tasks list is empty',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Add tasks to get started',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ); 
      }

      // tasks converted to list to sort them
      List tasks = boxTasks.values.toList();
      tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      // shows if there are tasks
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          // gets the task and assigns it to a variable
          Task task = tasks[index];
          String indexKey = 'key_' + task.id.toString();

          return InkWell(
              child: Card(
                // design effects
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),

                
                child: ExpansionTile(
                  title: ListTile(
                    leading: Checkbox(
                      value: task.isChecked,
                      onChanged: (bool? newValue) {
                        task.isChecked = newValue ?? false;
                        task.save();
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isChecked ? TextDecoration.lineThrough : TextDecoration.none
                      ),
                    ),
                    trailing: Text(
                      DateFormat('MMM d, yyyy').format(task.createdAt),
                    ),
                  ),
                  trailing: SizedBox.shrink(),
                  tilePadding: EdgeInsets.zero,
                  //children: <Widget>[ListTile(title: Text(""))],
                ),
              ),
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Task'),
                    content: Text(
                      'Are you sure you want to delete "${task.title}"?'
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
                          deleteTask(task.id);
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
            );
            
        }

      );
    }
  );
    
}