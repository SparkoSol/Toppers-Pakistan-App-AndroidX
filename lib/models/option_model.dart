import 'package:topperspakistan/models/_model.dart';

class OptionModel extends Model {
  int id;
  String name;
  int itemId;
  String createdAt;
  String updatedAt;
  List<Values> values;

  OptionModel(
      {this.id,
        this.name,
        this.itemId,
        this.createdAt,
        this.updatedAt,
        this.values});

  OptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    itemId = json['item_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['item_id'] = this.itemId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int id;
  String name;
  int optionId;
  String createdAt;
  String updatedAt;

  Values({this.id, this.name, this.optionId, this.createdAt, this.updatedAt});

  Values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    optionId = json['option_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['option_id'] = this.optionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}