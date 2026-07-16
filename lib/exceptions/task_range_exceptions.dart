class TaskRangeException implements Exception {
  final String message;
  TaskRangeException(this.message);

  @override
  String toString() => "Erreur de rang : $message";
}
