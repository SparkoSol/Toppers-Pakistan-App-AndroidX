import 'dart:convert';

import 'package:topperspakistan/models/item_model.dart';
import 'package:topperspakistan/services/_services.dart';

class ItemService extends Service<ItemModel> {
  @override
  ItemModel parse(Map<String, dynamic> json) {
    return ItemModel.fromJson(json);
  }
  String get route => "item";
}
