import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../business/controllers/country_controller.dart';
import 'country_detail_page.dart';
import 'country_list_item.dart';

class CountryListPage extends StatelessWidget {
  const CountryListPage({Key? key}) : super(key: key);

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
        key: const Key('addButton'),
        child: const Icon(Icons.add),
        onPressed: () async {
          Get.to(() => const CountryDetailPage(),
              arguments: [false, "Create new Country"]);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _getXlistView(),
      ),
    );
  }

  Widget _getXlistView() {
    CountryController controller = Get.find();
    return Obx(
      () => ListView.builder(
        itemCount: controller.objs.length,
        itemBuilder: (context, index) {
          final obj = controller.objs[index];
          return CountryListItem(obj);
        },
      ),
    );
  }
}