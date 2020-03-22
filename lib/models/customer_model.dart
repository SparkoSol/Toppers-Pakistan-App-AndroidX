import '_model.dart';

class CustomerModel extends Model {
  String name;
  String email;
  String password;
  String phone;
  int other;

  CustomerModel(
      {int id, this.name, this.email, this.password, this.phone,this.other})
      : super(id: id);

  CustomerModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          password: json['password'],
          phone: json['phone'],
          other: json['other']
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'other': other
      };
}
