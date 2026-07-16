import 'package:task_manager/helpers/menu_helper.dart';
import 'package:task_manager/managers/task_manager_impl.dart';
import 'package:task_manager/services/file_service.dart';

void main() async {
  final taskManagerImpl = TaskManagerImpl();
  final fileService = FileService(taskManagerImpl);
  final menuHelper = MenuHelper(taskManagerImpl);
  await fileService.loadAllfromJson();
  menuHelper.defaultMenu();
  menuHelper.snapAndDisplayDefaultMenu();
}
