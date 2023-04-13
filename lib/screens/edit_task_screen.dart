
import 'package:firebasetodoapps/bloc/bloc_export.dart';
import 'package:flutter/material.dart';

import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../model/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;

  const EditTaskScreen({Key? key, required this.oldTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: oldTask.title);
    TextEditingController descriptionController = TextEditingController(text: oldTask.description);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Edit task',
            style: TextStyle(fontSize: 21),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                label: Text(
                  'Title',
                  style: TextStyle(color: Colors.green),
                ),
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            controller: descriptionController,
            decoration: const InputDecoration(
                label: Text(
                  'Description',
                  style: TextStyle(color: Colors.green),
                ),
                border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var editedTask = Task(
                        title: titleController.text,
                        description: descriptionController.text,
                        id: oldTask.id,
                        isDone: false,
                        isFavorite: oldTask.isFavorite,
                        date: DateTime.now().toString());
                    context.read<TasksBloc>().add(EditTask(newTask:editedTask));
                    context.read<TasksBloc>().add(GetAllTasks());
                    Navigator.pop(context);
                  },
                  child: const Text('Save'))
            ],
          ),
        ],
      ),
    );
  }
}
