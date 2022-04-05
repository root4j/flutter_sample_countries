import 'package:countries/business/controllers/country_controller.dart';
import 'package:countries/business/repositories/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../business/controllers/task_controller.dart';
import '../../business/repositories/task_repository.dart';
import '../../business/services/sync_service.dart';
import '../../constants.dart';
import '../modules/countries/country_list_page.dart';
import '../modules/tasks/task_list_page.dart';
import 'side_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuOption navOption = MenuOption.load;
  SyncService srv = SyncService();

  @override
  Widget build(BuildContext context) {
    // Business Repositories
    Get.put(CountryRepository());
    Get.put(TaskRepository());
    // Business Controllers
    Get.put(CountryController());
    Get.put(TaskController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 51, 102, 1.0),
        title: Text(widget.title),
      ),
      drawer: SideNavigation(
        selectedIndex: navOption,
        setIndex: (MenuOption option) {
          setState(() {
            navOption = option;
          });
        },
      ),
      body: Builder(
        builder: (context) {
          switch (navOption) {
            case MenuOption.task:
              return const TaskListPage();
            case MenuOption.country:
              return const CountryListPage();
            default:
              return FutureBuilder(
                future: srv.fetchInitData(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Center(child: Text(snapshot.data ?? 'No Data'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
          }
        },
      ),
    );
  }
}
