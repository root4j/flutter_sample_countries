import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../business/controllers/task_controller.dart';
import '../../../business/models/task_model.dart';
import 'task_detail_page.dart';

class TaskListItem extends StatelessWidget {
  final TaskModel task;
  const TaskListItem(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find();
    int id = task.id ?? 0;
    return Center(
      child: Dismissible(
        direction: DismissDirection.startToEnd,
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child:
                Icon(Icons.cancel_rounded, color: Colors.black54, size: 32.0),
          ),
        ),
        onDismissed: (direction) {
          // Remove the item from the data source.
          taskController.deleteOne(task.id);
        },
        child: Card(
          key: Key('taskItem' + id.toString()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Checkbox(
                value: task.state,
                onChanged: (value) {
                  taskController.updateOne(
                    TaskModel(
                        id: task.id,
                        content: task.content,
                        date: task.date,
                        state: !task.state),
                  );
                },
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    task.content,
                    style: task.state
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black45)
                        : const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black),
                  ),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd').format(task.date),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => const TaskDetailPage(),
                      arguments: [true, task, task.id]);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black54,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
