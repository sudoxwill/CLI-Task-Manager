import 'package:task_manager/services/menu_helper.dart';
import 'package:task_manager/repositories/task_manager_impl.dart';

void main() async {
  final taskManager = TaskManagerImpl();
  final menuHelper = MenuHelper(taskManager);
  await taskManager.loadAllfromJson();
  menuHelper.defaultMenu();
  menuHelper.snapAndDisplayDefaultMenu();
}
