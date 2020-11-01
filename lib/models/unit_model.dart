import '_model.dart';

class UnitModel extends Model {
  final String name;

  UnitModel(
      {int id,
      this.name})
      : super(id: id);

  UnitModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['name']);

  @override
  Map<String, dynamic> toJson() => {
        'name': name
      };
}
