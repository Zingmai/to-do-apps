import 'package:equatable/equatable.dart';
import 'package:firebasetodoapps/repository/firestore_repository.dart';
import '../../model/task.dart';
import '../bloc_export.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<GetAllTasks>(_onGetAllTasks);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.create(task: event.task);
  }

  void _onGetAllTasks(GetAllTasks event, Emitter<TasksState> emit) async {
    List<Task> pendingTasks = [];
    List<Task> completedTasks = [];
    List<Task> favoriteTasks = [];
    List<Task> removedTasks = [];

    await FirestoreRepository.get().then((value) {
      value.forEach((task) {
        if (task.isDeleted == true) {
          removedTasks.add(task);
        } else {
          if (task.isFavorite == true) {
            favoriteTasks.add(task);
          }
          if (task.isDone == true) {
            completedTasks.add(task);
          } else {
            pendingTasks.add(task);
          }
        }
      });
    });
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    Task updateTask = event.task.copyWith(isDone: !event.task.isDone!);
    await FirestoreRepository.update(task: updateTask);
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async{
   await FirestoreRepository.delete(task: event.task);
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) async {
    Task removeTask = event.task.copyWith(isDeleted: true);
    await FirestoreRepository.update(task: removeTask);
  }

  void _onMarkFavoriteOrUnfavoriteTask(MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) async{
    Task task=event.task.copyWith(isFavorite: !event.task.isFavorite!);
    await  FirestoreRepository.update(task: task);
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) async{
    await FirestoreRepository.update(task: event.newTask);
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) async {
    Task restoreTask = event.task.copyWith(
        isDeleted: false,
        isDone: false,
        isFavorite: false,
        date: DateTime.now().toString());
    await FirestoreRepository.update(task: restoreTask);
  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) async{
  await FirestoreRepository.deleteAllRemovedTasks(taskList: state.removedTasks);
  }
}
