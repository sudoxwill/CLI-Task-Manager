import 'package:task_manager/models/base_task.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/exceptions/task_range_exceptions.dart';
import 'package:task_manager/managers/task_manager.dart';
import 'package:task_manager/managers/task_manager_impl.dart';
import 'package:test/test.dart';

void main() {
  late TaskManagerImpl taskManagerImpl;

  setUp(() {
    taskManagerImpl = TaskManagerImpl();
  });
  test(
    'Given a tasks list when addTask is called then one element is added to it',
    () {
      final myTask = Task(title: 'Task 1', priority: PriorityType.medium);

      taskManagerImpl.addTask(myTask);

      expect(taskManagerImpl.getAllTasks().length, 1);
    },
  );
  test(
    'Given a tasks list when getAllTasks is called with filter parameter at priority then the lis is filtered by priority',
    () {
      final myTask = Task(title: 'Task 1', priority: PriorityType.low);
      final myTask2 = Task(title: 'Task 2', priority: PriorityType.medium);
      final myTask3 = Task(title: 'Task 3', priority: PriorityType.high);

      taskManagerImpl.addTask(myTask);
      taskManagerImpl.addTask(myTask2);
      taskManagerImpl.addTask(myTask3);
      final tasks = taskManagerImpl.getAllTasks(TaskFilterType.byPriority);

      expect(tasks.first.priority, PriorityType.high);
    },
  );

  test(
    'Given a tasks list when deleteOrMarkTask is called with delete parameter equal to true then one element is deleted from it',
    () {
      final myTask = Task(title: 'Task 1', priority: PriorityType.medium);
      taskManagerImpl.addTask(myTask);

      taskManagerImpl.deleteOrMarkTask(0, true);

      expect(taskManagerImpl.getAllTasks().length, 0);
    },
  );

  test(
    'Given a tasks list when deleteOrMarkTask is called with delete parameter equal to false then one element is marked as done',
    () {
      final myTask = Task(title: 'Task 1', priority: PriorityType.medium);
      taskManagerImpl.addTask(myTask);

      taskManagerImpl.deleteOrMarkTask(0, false);

      expect(taskManagerImpl.getAllTasks()[0].isDone, true);
    },
  );

  test(
    'Given a tasks list when deleteOrMarkTask is called with an non valid index paramater then a TaskRangeException is thrown',
    () {
      final myTask = Task(title: 'Task 1', priority: PriorityType.medium);
      taskManagerImpl.addTask(myTask);

      expect(
        () => taskManagerImpl.deleteOrMarkTask(10, false),
        throwsA(isA<TaskRangeException>()),
      );
    },
  );
}
