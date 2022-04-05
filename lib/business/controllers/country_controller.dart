import 'package:get/get.dart';

import '../models/country_model.dart';
import '../repositories/country_repository.dart';

class CountryController extends GetxController {
  final _objs = <CountryModel>[].obs;

  CountryRepository repository = Get.find();

  List<CountryModel> get objs => _objs;

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

  Future<CountryModel> getOne(obj) async {
    var result = await repository.getOne(obj);
    return result;
  }

  Future<void> updateOne(CountryModel obj) async {
    await repository.update(obj);
    await getAll();
  }
}
