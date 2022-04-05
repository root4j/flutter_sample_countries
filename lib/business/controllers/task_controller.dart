import 'package:get/get.dart';

import '../models/task_model.dart';
import '../repositories/task_repository.dart';

class TaskController extends GetxController {
  final _objs = <TaskModel>[].obs;

  TaskRepository repository = Get.find();

  List<TaskModel> get objs => _objs;

  @override
  onInit() {
    super.onInit();
    getAll();
  }

  Future<void> addOne(obj) async {
    await repository.add(obj);
    await getAll();
  }

  Future<void> deleteAll() async {
    await repository.deleteAll();
    await getAll();
  }

  Future<void> deleteOne(obj) async {
    await repository.deleteOne(obj);
    await getAll();
  }

  Future<void> getAll() async {
    _objs.value = await repository.getAll();
  }

  Future<TaskModel> getOne(obj) async {
    var result = await repository.getOne(obj);
    return result;
  }

  Future<void> updateOne(TaskModel obj) async {
    await repository.update(obj);
    await getAll();
  }
}
