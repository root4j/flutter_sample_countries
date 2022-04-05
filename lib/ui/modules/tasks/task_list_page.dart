import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../business/controllers/task_controller.dart';
import 'task_detail_page.dart';
import 'task_list_item.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //HomeController controller = Get.find();
    //TaskController taskController = Get.find();
    return Scaffold(
      //appBar: AppBar(title: const Text("Task list"), actions: <Widget>[
      //  IconButton(
      //      key: const Key('deleteAllButton'),
      //      onPressed: () {
      //        // Realiza el llamado al metodo para eliminar todas las tareas
      //        taskController.deleteAll();
      //      },
      //      icon: const Icon(Icons.delete))
      //]),
      floatingActionButton: FloatingActionButton(
        key: const Key('addTaskButton'),
        child: const Icon(Icons.add),
        onPressed: () async {
          Get.to(() => const TaskDetailPage(),
              arguments: [false, "Create new Task"]);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _getXlistView(),
      ),
    );
  }

  Widget _getXlistView() {
    TaskController taskController = Get.find();
    return Obx(
      () => ListView.builder(
        itemCount: taskController.objs.length,
        itemBuilder: (context, index) {
          final obj = taskController.objs[index];
          return TaskListItem(obj);
        },
      ),
    );
  }
}