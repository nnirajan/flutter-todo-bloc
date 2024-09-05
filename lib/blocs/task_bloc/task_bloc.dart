import '../bloc_exports.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_bloc/models/task.dart';

part 'task_state.dart';
part 'task_event.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTaskEvent>(_addTask);

    on<UpdateTaskEvent>(_updateTask);

    on<RemoveTaskEvent>(_removeTask);

    on<DeleteTaskEvent>(_deleteTask);

    on<FavoriteTaskEvent>(_favoriteTask);

    on<EditTaskEvent>(_editTask);

    on<RestoreTaskEvent>(_restoreTask);
  }

  void _addTask(AddTaskEvent event, Emitter<TaskState> emit) {
    final addedTask = event.task;

    List<Task> pendingTasks = List.from(state.pendingTasks)..add(addedTask);

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _updateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;

    List<Task> completedTasks = state.completedTasks;

    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      // task in pending
      pendingTasks = List.from(pendingTasks)..remove(task);

      completedTasks = List.from(completedTasks)
        ..insert(0, task.copyWith(isDone: true));

      if (task.isFavorite == true) {
        int favoriteIndex = favoriteTasks.indexOf(task);

        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(favoriteIndex, task.copyWith(isDone: true));
      }
    } else {
      // task in completed
      pendingTasks = List.from(pendingTasks)
        ..insert(0, task.copyWith(isDone: false));

      completedTasks = List.from(completedTasks)..remove(task);

      if (task.isFavorite == true) {
        int favoriteIndex = favoriteTasks.indexOf(task);

        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(favoriteIndex, task.copyWith(isDone: false));
      }
    }

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  // move to the bin
  void _removeTask(RemoveTaskEvent event, Emitter<TaskState> emit) {
    final removedTask = event.task;

    List<Task> pendingTasks = List.from(state.pendingTasks)
      ..remove(removedTask);

    List<Task> completedTasks = List.from(state.completedTasks)
      ..remove(removedTask);

    List<Task> favoriteTasks = List.from(state.favoriteTasks)
      ..remove(removedTask);

    List<Task> removedTasks = List.from(state.removedTasks)
      ..add(removedTask.copyWith(isDeleted: true));

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  // deletes the task permanently
  void _deleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) {
    final deletedTask = event.task;

    List<Task> removedTasks = List.from(state.removedTasks)
      ..remove(deletedTask);

    emit(
      TaskState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  void _favoriteTask(FavoriteTaskEvent event, Emitter<TaskState> emit) {
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;

    List<Task> completedTasks = state.completedTasks;

    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      // task is pending
      int taskIndex = pendingTasks.indexOf(task);

      if (task.isFavorite == false) {
        // adding into favorite
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: true));

        favoriteTasks = List.from(favoriteTasks)
          ..insert(0, task.copyWith(isFavorite: true));
      } else {
        // removing from favorite
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: false));

        favoriteTasks = List.from(favoriteTasks)..remove(task);
      }
    } else {
      // task in completed
      var taskIndex = completedTasks.indexOf(task);

      if (task.isFavorite == false) {
        // adding into favorite
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: true));

        favoriteTasks = List.from(favoriteTasks)
          ..insert(0, task.copyWith(isFavorite: true));
      } else {
        // removing from favorite
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: false));

        favoriteTasks = List.from(favoriteTasks)..remove(task);
      }
    }

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _editTask(EditTaskEvent event, Emitter<TaskState> emit) {
    final oldTask = event.oldTask;
    final newTask = event.newTask;

    List<Task> favoriteTasks = state.favoriteTasks;

    if (oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(oldTask)
        ..insert(0, newTask);
    }

    List<Task> pendingTasks = List.from(state.pendingTasks)
      ..remove(oldTask)
      ..insert(0, newTask);

    List<Task> completedTasks = List.from(state.completedTasks)
      ..remove(oldTask);

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _restoreTask(RestoreTaskEvent event, Emitter<TaskState> emit) {
    List<Task> removedTasks = List.from(state.removedTasks)..remove(event.task);

    List<Task> pendingTasks = List.from(state.pendingTasks)
      ..insert(
        0,
        event.task.copyWith(
          isDeleted: false,
          isDone: false,
          isFavorite: false,
        ),
      );

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
