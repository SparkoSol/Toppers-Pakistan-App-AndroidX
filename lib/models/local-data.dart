import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:topperspakistan/cart_list.dart';
import 'package:topperspakistan/models/customer_model.dart';

import 'branch_model.dart';

class LocalData {
  static CustomerModel currentCustomer;
  static File _dataFile;
  static bool _signedIn = false;
  static BranchModel branchId;

  static CustomerModel getProfile() {
    return currentCustomer;
  }

  static void logout() {
    currentCustomer = null;
    branchId = null;
    writeData();
  }

  static void setProfile(CustomerModel profile) {
    _signedIn = profile != null;
    currentCustomer = profile;
    writeData();
  }

  static void setBranch(branch) {
    print('Set Branch');
    print(branch.id);
    branchId = branch;
    CartList.emptyCartList();
    writeData();
  }

  static void writeData() {
    if (currentCustomer != null && branchId != null) {
      _dataFile.writeAsString(jsonEncode(
        {'customer': currentCustomer.toJson(), 'branchId': branchId.toJson()},
      ));
    }

    _dataFile.writeAsString(jsonEncode(
      {'customer': currentCustomer, 'branchId': branchId},
    ));
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
      currentCustomer = CustomerModel.fromJson(data['customer']);
      branchId = BranchModel.fromJson(data['branchId']);
      print('We are Reading File');
      print(branchId);
      _signedIn = true;
    } catch (ex) {
      print('Error Reading File');
      _signedIn = false;
    }
  }
}
