import 'dart:convert';

import 'package:topperspakistan/models/customer_model.dart';
import 'package:topperspakistan/services/_services.dart';
import 'package:http/http.dart' as http;

class CustomerService extends Service<CustomerModel> {
  @override
  CustomerModel parse(Map<String, dynamic> json) {
    return CustomerModel.fromJson(json);
  }

  Future<CustomerModel> insert(CustomerModel customerModel) async {
    var jsonData = jsonEncode(customerModel);
    print(jsonData);
    print("$apiUrl/register-customer");
    try {
      var response = await http.post(
          Uri.encodeFull("$apiUrl/register-customer"),
          body: jsonData,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          });
      var data = jsonDecode(response.body);
      return parse(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CustomerModel> login(CustomerModel customerModel) async {
    var jsonData = jsonEncode(customerModel);
    try {
      print('waiting');
      var response = await http.post(Uri.encodeFull("$apiUrl/login-customer"),
          body: jsonData,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          });
      var data = jsonDecode(response.body);
      print(parse(data).email);
      return parse(data);
    } catch (e) {
      return null;
    }
  }

  Future<CustomerModel> changePassword(customerModel,id) async {
    var jsonData = jsonEncode(customerModel);
    print(jsonData);
    try {
      print('waiting');
      var response = await http.post(Uri.encodeFull("$apiUrl/change-customer-password/$id"),
          body: jsonData,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          });
      var data = jsonDecode(response.body);
      print(parse(data).email);
      return parse(data);
    } catch (e) {
      return null;
    }
  }

  String get route => "customer";
}
