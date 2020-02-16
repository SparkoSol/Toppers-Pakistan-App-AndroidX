import 'package:topperspakistan/models/unit_model.dart';
import 'package:topperspakistan/services/_services.dart';

class UnitService extends Service<UnitModel> {
  @override
  UnitModel parse(Map<String, dynamic> json) {
    return UnitModel.fromJson(json);
  }

  String get route => "unit";
}
