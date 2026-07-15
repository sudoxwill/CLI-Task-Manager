import 'dart:convert';
import 'dart:io';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_exceptions.dart';
import 'package:task_manager/task_manager.dart';

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
  saveAllToJson() async {
    try {
      final File file = File('tasks.json');
      final List<Map<String, dynamic>> jsonList = _tasks
          .map((e) => e.toJson())
          .toList();
      final String stringList = jsonEncode(jsonList);
      await file.writeAsString(stringList);
    } catch (e) {
      print('Les données n\'ont pas été enregistrées. Reéssaye!');
    }
  }

  @override
  loadAllfromJson() async {
    try {
      final File file = File('tasks.json');

      if (!await file.exists()) {
        _tasks = [];
      }

      final String stringList = await file.readAsString();

      final List<dynamic> jsonList = jsonDecode(stringList);

      _tasks = jsonList.map((e) => Task.fromJson(e)).toList();
    } catch (e) {
      print('L\'application ne s\'est pas bien lancée. Relance!');
    }
  }
}
