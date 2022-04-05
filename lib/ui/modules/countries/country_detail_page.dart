import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../business/controllers/country_controller.dart';
import '../../../business/models/country_model.dart';

class CountryDetailPage extends StatefulWidget {
  const CountryDetailPage({Key? key}) : super(key: key);

  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  final bool _editing = Get.arguments[0];
  late CountryModel obj;

  final ctrlCode = TextEditingController();
  final ctrlName = TextEditingController();
  final ctrlContinent = TextEditingController();
  final ctrlLatitude = TextEditingController();
  final ctrlLongitude = TextEditingController();
  final ctrlTimezone = TextEditingController();
  final ctrlFlag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_editing) {
      obj = Get.arguments[1];
      ctrlCode.text = obj.code;
      ctrlName.text = obj.name;
      ctrlContinent.text = obj.continent!;
      ctrlLatitude.text = obj.latitude!.toString();
      ctrlLongitude.text = obj.longitude!.toString();
      ctrlTimezone.text = obj.timezone!;
      ctrlFlag.text = obj.flag!;
    } else {
      ctrlCode.text = "";
      ctrlName.text = "";
      ctrlContinent.text = "";
      ctrlLatitude.text = "";
      ctrlLongitude.text = "";
      ctrlTimezone.text = "";
      ctrlFlag.text = "";
    }
    CountryController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(_editing ? obj.name : Get.arguments[1]),
        actions: _editing
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // Realiza el llamado al metodo para eliminar
                    await controller.deleteOne(obj.code);
                    Get.back();
                  },
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ctrlCode,
              decoration: const InputDecoration(
                labelText: 'Code',
                contentPadding: EdgeInsets.only(left: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ctrlName,
              decoration: const InputDecoration(
                labelText: 'Name',
                contentPadding: EdgeInsets.only(left: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ctrlContinent,
              decoration: const InputDecoration(
                labelText: 'Continent',
                contentPadding: EdgeInsets.only(left: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ctrlLatitude,
              decoration: const InputDecoration(
                labelText: 'Latitude',
                contentPadding: EdgeInsets.only(left: 12),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ctrlLongitude,
              decoration: const InputDecoration(
                labelText: 'Longitude',
                contentPadding: EdgeInsets.only(left: 12),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ctrlTimezone,
              decoration: const InputDecoration(
                labelText: 'Timezone',
                contentPadding: EdgeInsets.only(left: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ctrlFlag,
              decoration: const InputDecoration(
                labelText: 'Flag',
                contentPadding: EdgeInsets.only(left: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        String title = 'error';
                        String message = "";
                        bool showError = false;
                        if (_editing) {
                          // Llamar metodo para actualizar una tarea
                          // existente, en caso de edición
                          var obj = CountryModel(
                              code: this.obj.code,
                              name: ctrlName.text,
                              continent: ctrlContinent.text,
                              latitude: double.parse(ctrlLatitude.text),
                              longitude: double.parse(ctrlLongitude.text),
                              timezone: ctrlTimezone.text,
                              flag: ctrlFlag.text);
                          await controller
                              .updateOne(obj)
                              .onError((error, stackTrace) {
                            error.printError();
                            message = error.toString();
                            showError = true;
                          });
                        } else {
                          // Llamar metodo para crear una tarea
                          var obj = CountryModel(
                              code: ctrlCode.text,
                              name: ctrlName.text,
                              continent: ctrlContinent.text,
                              latitude: double.parse(ctrlLatitude.text),
                              longitude: double.parse(ctrlLongitude.text),
                              timezone: ctrlTimezone.text,
                              flag: ctrlFlag.text);
                          await controller
                              .addOne(obj)
                              .onError((error, stackTrace) {
                            error.printError();
                            message = error.toString();
                            showError = true;
                          });
                        }
                        if (showError) {
                          Get.snackbar(title, message,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green[400],
                              duration: const Duration(milliseconds: 1500),
                              colorText: Colors.white,
                              icon: const Icon(Icons.update),
                              barBlur: 0.5);
                        } else {
                          Get.back();
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
