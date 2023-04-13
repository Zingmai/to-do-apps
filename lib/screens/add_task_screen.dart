
import 'package:firebasetodoapps/bloc/bloc_export.dart';
import 'package:flutter/material.dart';

import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../model/task.dart';
import '../services/guid_gen.dart';


class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController=TextEditingController();
    TextEditingController descriptionController=TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          const Text('Add task',style: TextStyle(fontSize: 21),),
          const SizedBox(height: 10,),

          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                label: Text('Title',style: TextStyle(color: Colors.green),
                ),
                border: OutlineInputBorder()
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            controller: descriptionController,
            decoration: const InputDecoration(
                label: Text('Description',style: TextStyle(color: Colors.green),
                ),
                border: OutlineInputBorder()
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(onPressed: (){
                var task=Task(
                  id: GUIDGen.generate(),
                    title: titleController.text,
                    description: descriptionController.text,
                  date: DateTime.now().toString()

                );
                context.read<TasksBloc>().add(AddTask(task: task));
                context.read<TasksBloc>().add(GetAllTasks());
                Navigator.pop(context);
              }, child: const Text('Add'))
            ],
          ),

        ],
      ),
    );
  }
}
