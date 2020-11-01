import 'package:topperspakistan/models/subCategories_model.dart';
import 'package:topperspakistan/services/_services.dart';

class SubCategoryService extends Service<SubCategoryModel> {
  @override
  SubCategoryModel parse(Map<String, dynamic> json) {
    return SubCategoryModel.fromJson(json);
  }

  String get route => "subCategory";
}
