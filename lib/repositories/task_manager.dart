import 'package:task_manager/models/task.dart';

enum TaskFilterType { byDefault, byPriority, byDate }

abstract class TaskManager<T extends BaseTask> {
  /// avec tri par priorité ou date
  void addTask(T item);
  List<T> getAllTasks([TaskFilterType taskFilter = TaskFilterType.byDefault]);
  void deleteOrMarkTask(int index, bool delete);

  /// Fichier JSON local
  Future<void> saveAllToJson();
  Future<void> loadAllfromJson();
}
