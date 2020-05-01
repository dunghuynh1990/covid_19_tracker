import 'package:covid19tracker/models/world_wide_model.dart';
import 'package:covid19tracker/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  Future getAll() async {
    http.Response response = await http.get('$kBASE_URL/$kAPI_ALL');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getAllContinents() async {
    http.Response response = await http.get('$kBASE_URL/$kAPI_CONTINENTS');
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

}