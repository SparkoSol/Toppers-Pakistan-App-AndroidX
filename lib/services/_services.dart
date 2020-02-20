import 'dart:convert';

import 'package:topperspakistan/models/_model.dart';

import 'package:http/http.dart' as http;
import 'package:topperspakistan/models/local-data.dart';

abstract class Service<T extends Model> {
  final apiUrl = "http://toppers-pakistan.toppers-mart.com/api";

  String get route;

  Future<List<T>> fetchAll() async {
    var response = await http.get(Uri.encodeFull("$apiUrl/$route"),
        headers: {"Accept": "application/json"});

    var data = jsonDecode(response.body) as List;

    return data.map((item) => parse(item)).toList();
  }

  Future<List<T>> fetchAllById(id) async {
    var response = await http.get(Uri.encodeFull("$apiUrl/$route/$id"),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }

  Future<List<T>> fetchAllByCustomerId() async {
    print(LocalData.getProfile().id);
    var response = await http.get(
        Uri.encodeFull(
            "$apiUrl/$route/" + LocalData.currentCustomer.id.toString()),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }

  Future<T> insert(T t) async {
    var jsonData = jsonEncode(t);
    var response = await http.post(Uri.encodeFull("$apiUrl/$route"),
        body: jsonData,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    try {
      var data = jsonDecode(response.body);
      return parse(data);
    } catch (e) {
      return null;
    }
  }

  T parse(Map<String, dynamic> json);
}
