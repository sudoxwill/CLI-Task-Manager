import 'package:intl/intl.dart';
import 'package:task_manager/models/base_task.dart';

class Task extends BaseTask {
  Task({
    required super.title,
    required super.priority,
    super.date,
    super.isDone,
  });
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    priority: PriorityType.values.firstWhere((e) => e.name == json['priority']),
    date: json['date'] == null
        ? null
        : DateFormat('dd/MM/yyyy').parse(json['date']),
    isDone: json['is_done'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'priority': priority.name,
    'date': date == null ? null : DateFormat('dd/MM/yyyy').format(date!),
    'is_done': isDone,
  };
}
