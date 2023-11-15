import 'dart:convert';

import 'package:assignment_heliverse/Usermodel.dart';
import 'package:http/http.dart' as http;

class FetchUser {
  var data = [];
  List<Userlist> results = [];
  String fetchurl = "https://mocki.io/v1/5160744b-d3c3-4165-8580-3b3515253846";
  Future<List<Userlist>> getUserList({String? query}) async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => Userlist.fromJson(e)).toList();
        if (query != null) {
          results = results.where(
              (element) => element.firstName!.toLowerCase().contains(query.toLowerCase())).toList();
        }
      } else {
        print('api error');
      }
    } on Exception catch (e) {
      print("error: $e");
    }
    return results;
  }
}
