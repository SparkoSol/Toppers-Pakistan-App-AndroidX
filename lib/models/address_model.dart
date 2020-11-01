
import 'package:topperspakistan/models/_model.dart';

class AddressModel extends Model {
  String customerId;
  String description;
  String house;
  String street;
  String area;
  String city;
  String mobile;

  AddressModel({int id,this.description,  this.customerId, this.house, this.street,this.area,this.city,this.mobile}) : super(id: id);

  AddressModel.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], 
      customerId: json['customer_id'].toString(), 
      description: json['description'],
      house: json['house'],
      street: json['street'],
      area: json['area'],
      city: json['city'],
      mobile: json['mobile']
      );

  @override
  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'description': description,
        'house': house,
        'street': street,
        'area': area,
        'city': city,
        'mobile': mobile
      };  
}