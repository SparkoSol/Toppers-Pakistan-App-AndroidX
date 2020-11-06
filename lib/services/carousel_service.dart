import 'package:topperspakistan/models/carousel_model.dart';
import 'package:topperspakistan/services/_services.dart';

class CarouselService extends Service<CarouselModel> {
  @override
  CarouselModel parse(Map<String, dynamic> json) {
    return CarouselModel.fromJson(json);
  }

  String get route => "carousel";
}
