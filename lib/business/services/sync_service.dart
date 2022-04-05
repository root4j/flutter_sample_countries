import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../controllers/connectivity_controller.dart';
import '../models/country_model.dart';
import '../repositories/country_repository.dart';

class SyncService {
  Future<String> fetchInitData() async {
    ConnectivityController connectivityController = Get.find();
    if (connectivityController.connected) {
      final url = Uri.https(
        'restcountries.com',
        '/v3.1/all',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);

        // Countries
        Iterable countries = result;
        CountryRepository countryRepo = CountryRepository();
        for (var model in countries) {
          var obj = CountryModel.fromJson(model);
          countryRepo.add(obj);
        }

        return 'Data Loaded';
      } else {
        throw Exception('Failed to load data');
      }
    } else {
        return '';
    }
  }
}
