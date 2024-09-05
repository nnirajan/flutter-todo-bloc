part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favoriteTasks;
  final List<Task> removedTasks;

  const TaskState({
    this.pendingTasks = const [],
    this.completedTasks = const [],
    this.favoriteTasks = const [],
    this.removedTasks = const [],
  });

  @override
  List<Object?> get props => [
        pendingTasks,
        completedTasks,
        favoriteTasks,
        removedTasks,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList(),
      'removedTasks': pendingTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      pendingTasks: List<Task>.from(
        (map['pendingTasks']?.map((x) => Task.fromMap(x))),
      ),
      completedTasks: List<Task>.from(
        (map['completedTasks']?.map((x) => Task.fromMap(x))),
      ),
      favoriteTasks: List<Task>.from(
        (map['favoriteTasks']?.map((x) => Task.fromMap(x))),
      ),
      removedTasks: List<Task>.from(
        (map['removedTasks']?.map((x) => Task.fromMap(x))),
      ),
    );
  }
}
