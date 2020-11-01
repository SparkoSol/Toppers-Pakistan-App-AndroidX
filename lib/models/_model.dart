abstract class Model {
  int id;

  Model({this.id});

  Map<String, dynamic> toMap() => {
        "id": this.id,
      };

  Model.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
