import 'package:topperspakistan/models/_model.dart';

class NotificationModel extends Model {
  int id;
  String title;
  String message;

  NotificationModel({this.id, this.title, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}