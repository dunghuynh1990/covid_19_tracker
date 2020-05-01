import 'package:covid19tracker/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  Future getWorldWideStats() async {
    http.Response response = await http.get('$kBASE_URL/$kAPI_ALL');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getContinentsStats() async {
    http.Response response = await http.get('$kBASE_URL/$kAPI_CONTINENTS');
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

}