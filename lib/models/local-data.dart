import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:topperspakistan/models/customer_model.dart';

class LocalData {
  static CustomerModel currentCustomer;
  static File _dataFile;
  static bool _signedIn = false;

  static CustomerModel getProfile() {
    return currentCustomer;
  }

  static void setProfile(CustomerModel profile) {
    _signedIn = profile != null;
    currentCustomer = profile;
    writeData();
  }

  static void writeData() {
    if (currentCustomer != null) {
      _dataFile.writeAsString(jsonEncode(currentCustomer.toJson()));
    }

    _dataFile.writeAsString(jsonEncode(currentCustomer));
  }

  static void readData() {}

  static isSignedIn() => _signedIn;

  static initPath() async {
    var dir = await getApplicationDocumentsDirectory();

    _dataFile = File(dir.path + "/data.json");

    try {
      await _dataFile.create();
    } catch (ex) {
      print(ex);
    }

    try {
      Map<String, dynamic> data = jsonDecode(await _dataFile.readAsString());

      currentCustomer = CustomerModel.fromJson(data);
      _signedIn = true;
    } catch (ex) {
      _signedIn = false;
    }
  }
}