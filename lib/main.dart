import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'business/controllers/connectivity_controller.dart';
import 'ui/generals/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Inject Controller
  Get.put(ConnectivityController());
  // Connection Controller
  ConnectivityController controller = Get.find();
  Connectivity().onConnectivityChanged.listen((connectivityStatus) {
    controller.connectivity = connectivityStatus;
  });
  // Run App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String homeTitle = 'Examples - Flutter';

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Examples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/home': (context) => HomePage(title: homeTitle),
      },
      home: HomePage(title: homeTitle),
    );
  }
}
