
import 'package:flutter/material.dart';

import '../bloc/bloc_export.dart';
import '../widgets/task_list.dart';
import 'my_drawer.dart';


class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);
  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            centerTitle: true,
            actions: [
              PopupMenuButton(itemBuilder: (context) => [
                PopupMenuItem(child: TextButton.icon(onPressed: null, 
                    icon: Icon(Icons.delete_forever), 
                    label: Text('Delete all tasks'),
                ),
                  onTap: () => {
                    context.read<TasksBloc>().add(DeleteAllTasks()),
                    context.read<TasksBloc>().add(GetAllTasks()),
                  }

                )
              ],)
            ],

          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Center(
                child: Chip(
                  label: Text(
                    '${state.removedTasks.length} Tasks',
                    style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TasksList(tasksList: state.removedTasks)
            ],

          ),

        );
      },
    );
  }
}
