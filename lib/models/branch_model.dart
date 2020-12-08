
import 'package:topperspakistan/models/_model.dart';

class BranchModel extends Model {
  String restaurantId;
  String name;
  String email;
  String address;
  String phone;
  String image;
  int delivery;

  BranchModel({int id,this.name,this.restaurantId,this.email,this.address,this.phone,this.image,this.delivery}) : super(id: id);

  BranchModel.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], 
      restaurantId: json['restaurant_id'].toString(), 
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      image: json['image'],
      delivery: json['delivery']
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'restaurant_id': restaurantId,
        'name': name,
        'email': email,
        'address': address,
        'phone': phone,
        'image': image,
        'delivery': delivery
      };  
}