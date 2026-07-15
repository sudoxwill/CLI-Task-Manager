import 'package:intl/intl.dart';

enum PriorityType { low, medium, high }

abstract class BaseTask {
  String title;
  PriorityType priority;
  bool isDone;
  DateTime? date;
  BaseTask({
    required this.title,
    required this.priority,
    this.isDone = false,
    this.date,
  });
}

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
    isDone: json['is_done'] == 1 ? true : false,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'priority': priority.name,
    'date': date == null ? null : DateFormat('dd/MM/yyyy').format(date!),
    'is_done': isDone == true ? 1 : 0,
  };
}
