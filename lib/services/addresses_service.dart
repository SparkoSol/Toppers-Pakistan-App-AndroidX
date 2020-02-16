import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:topperspakistan/models/address_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/services/_services.dart';

class AddressService extends Service<AddressModel> {
  @override
  AddressModel parse(Map<String, dynamic> json) {
    return AddressModel.fromJson(json);
  }

  Future<AddressModel> insert(AddressModel addressModel) async {
    // print("Model=> " +addressModel.toString());
    var jsonData = jsonEncode(addressModel);
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

  void delete(AddressModel addressModel) async {
    var id = addressModel.id;
    print("id=>" + id.toString());
    var response = await http.delete(
        Uri.encodeFull("$apiUrl/$route/$id"),
        headers: {"Content-Type": "application/json"});
    print("Response=>" + response.body);
  }

  String get route => "address";
}
