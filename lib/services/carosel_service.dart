import 'package:topperspakistan/models/carosel_model.dart';
import 'package:topperspakistan/services/_services.dart';

class CaroselService extends Service<CaroselModel> {
  @override
  CaroselModel parse(Map<String, dynamic> json) {
    return CaroselModel.fromJson(json);
  }

  String get route => "carosel";
}
