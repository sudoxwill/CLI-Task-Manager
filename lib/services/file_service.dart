import 'dart:convert';
import 'dart:io';
import 'package:task_manager/managers/task_manager_impl.dart';
import 'package:task_manager/models/task.dart';

class FileService {
  final TaskManagerImpl taskManagerImpl;
  const FileService(this.taskManagerImpl);

  Future<void> saveAllToJson() async {
    try {
      final File file = File('tasks.json');
      final List<Map<String, dynamic>> jsonList = taskManagerImpl
          .getAllTasks()
          .map((e) => e.toJson())
          .toList();
      final String stringList = jsonEncode(jsonList);
      await file.writeAsString(stringList);
    } catch (e) {
      print('Les données n\'ont pas été enregistrées. Reéssaye!');
    }
  }

  Future<void> loadAllfromJson() async {
    try {
      final File file = File('tasks.json');

      if (!await file.exists()) {
        return;
      }

      final String stringList = await file.readAsString();

      final List<dynamic> jsonList = jsonDecode(stringList);

      taskManagerImpl.initTasks(jsonList.map((e) => Task.fromJson(e)).toList());
    } catch (e) {
      print('L\'application ne s\'est pas bien lancée. Relance!');
    }
  }
}
