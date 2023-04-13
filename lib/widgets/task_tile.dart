import 'package:firebasetodoapps/bloc/bloc_export.dart';
import 'package:firebasetodoapps/widgets/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/task.dart';
import '../screens/edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? {
            ctx.read<TasksBloc>().add(DeleteTask(task: task)),
            ctx.read<TasksBloc>().add(GetAllTasks())
          }
        : {
            ctx.read<TasksBloc>().add(RemoveTask(task: task)),
            ctx.read<TasksBloc>().add(GetAllTasks())
          };
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: EditTaskScreen(oldTask: task)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(children: [
              task.isFavorite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.date)))
                    ]),
              ),
            ]),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                        context.read<TasksBloc>().add(GetAllTasks());
                      }
                    : null,
              ),
              PopupMenu(
                  task: task,
                  cancelOrDeleteCallback: () =>
                      _removeOrDeleteTask(context, task),
                  likeOrDislikeCallback: () => {
                        context.read<TasksBloc>().add(
                              MarkFavoriteOrUnfavoriteTask(task: task),
                            ),
                        context.read<TasksBloc>().add(GetAllTasks()),
                      },
                  editTaskCallBack: () {
                    Navigator.of(context).pop();
                    _editTask(context);
                  },
                  restoreTaskCallBack: () => {
                        context.read<TasksBloc>().add(RestoreTask(task: task)),
                        context.read<TasksBloc>().add(GetAllTasks()),
                      }),
            ],
          ),
        ],
      ),
    );
  }
}
