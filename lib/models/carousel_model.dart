import '_model.dart';

class CarouselModel extends Model {
  String image;

  CarouselModel({int id, this.image}) : super(id: id);

  CarouselModel.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], image: json['image']);

  @override
  Map<String, dynamic> toJson() => {'image': image};
}
