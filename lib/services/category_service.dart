import 'package:topperspakistan/models/category_model.dart';
import 'package:topperspakistan/services/_services.dart';

class CategoryService extends Service<CategoryModel> {
  @override
  CategoryModel parse(Map<String, dynamic> json) {
    return CategoryModel.fromJson(json);
  }

  String get route => "category";
}
