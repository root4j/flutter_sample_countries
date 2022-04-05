import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../business/controllers/country_controller.dart';
import '../../../business/models/country_model.dart';
import 'country_detail_page.dart';

class CountryListItem extends StatelessWidget {
  final CountryModel obj;
  const CountryListItem(this.obj, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountryController controller = Get.find();
    String id = obj.code;
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
          controller.deleteOne(obj.code);
        },
        child: Card(
          key: Key('objItem' + id.toString()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Code:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(obj.code)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Name:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(obj.name)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Continent:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(obj.continent!)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Flag:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Image.network(obj.flag!, height: 50),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => const CountryDetailPage(),
                      arguments: [true, obj, obj.code]);
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