import '_model.dart';

class CustomerModel extends Model {
  String name;
  String email;
  String password;
  String phone;
  String address;

  CustomerModel(
      {int id, this.name, this.email, this.password, this.phone, this.address})
      : super(id: id);

  CustomerModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          password: json['password'],
          phone: json['phone'],
          address: json['address'].toString(),
        );

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'address': address
      };
}
