import 'dart:convert';
import 'package:topperspakistan/models/option_model.dart';
import 'package:topperspakistan/services/_services.dart';
import 'package:http/http.dart' as http;

class OptionService extends Service<OptionModel> {
  @override
  OptionModel parse(Map<String, dynamic> json) {
    return OptionModel.fromJson(json);
  }
  
  Future<List<OptionModel>> fetchAllOptions(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "$apiUrl/option/item/$id/app"),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }
  
  String get route => "option";
}