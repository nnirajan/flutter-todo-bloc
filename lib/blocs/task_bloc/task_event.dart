part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent({required this.task});
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  const DeleteTaskEvent({required this.task});
}

class RemoveTaskEvent extends TaskEvent {
  final Task task;

  const RemoveTaskEvent({required this.task});
}

class FavoriteTaskEvent extends TaskEvent {
  final Task task;

  const FavoriteTaskEvent({required this.task});
}

class EditTaskEvent extends TaskEvent {
  final Task oldTask;
  final Task newTask;

  const EditTaskEvent({required this.oldTask, required this.newTask});

  @override
  List<Object?> get props => [oldTask, newTask];
}

class RestoreTaskEvent extends TaskEvent {
  final Task task;

  const RestoreTaskEvent({required this.task});
  
  @override
  List<Object?> get props => [task];
}
