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
