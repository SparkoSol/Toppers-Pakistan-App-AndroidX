import 'package:topperspakistan/models/carousel_model.dart';
import 'package:topperspakistan/models/notification_model.dart';
import 'package:topperspakistan/services/_services.dart';

class NotificationService extends Service<NotificationModel> {
  @override
  NotificationModel parse(Map<String, dynamic> json) {
    return NotificationModel.fromJson(json);
  }

  String get route => "notification/new";
}
