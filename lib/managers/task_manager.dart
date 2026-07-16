import 'package:task_manager/models/task.dart';

enum TaskFilterType { byDefault, byPriority, byDate }

abstract class TaskManager<T extends Task> {
  /// avec tri par priorité ou date
  void addTask(T item);
  List<T> getAllTasks([TaskFilterType taskFilter = TaskFilterType.byDefault]);
  void deleteOrMarkTask(int index, bool delete);

  void initTasks(List<Task> tasks);
}
