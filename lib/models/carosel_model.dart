import '_model.dart';

class CaroselModel extends Model {
  String image;

  CaroselModel({int id, this.image}) : super(id: id);

  CaroselModel.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], image: json['image']);

  @override
  Map<String, dynamic> toJson() => {'image': image};
}
