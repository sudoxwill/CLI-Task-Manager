import 'package:task_manager/models/task.dart';
import 'package:task_manager/exceptions/task_range_exceptions.dart';
import 'package:task_manager/managers/task_manager.dart';

class TaskManagerImpl implements TaskManager<Task> {
  List<Task> _tasks = [];

  @override
  deleteOrMarkTask(int index, bool delete) {
    if (_tasks.length <= index) {
      throw TaskRangeException('Cet index n\'existe pas.');
    }

    delete ? _tasks.removeAt(index) : _tasks[index].isDone = true;
  }

  @override
  List<Task> getAllTasks([
    TaskFilterType taskFilter = TaskFilterType.byDefault,
  ]) {
    // Filtrage
    if (taskFilter == TaskFilterType.byPriority) {
      _tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    } else if (taskFilter == TaskFilterType.byDate) {
      // Tentative de filtrage par date
      _tasks.sort((a, b) {
        if (a.date == null && b.date == null) return 0;
        if (a.date == null) return -1;
        if (b.date == null) return 1;
        return a.date!.compareTo(b.date!);
      });
    }

    return _tasks;
  }

  @override
  addTask(Task task) {
    _tasks.add(task);
  }

  @override
  void initTasks(List<Task> tasks) {
    _tasks = tasks;
  }
}
