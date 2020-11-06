import 'package:topperspakistan/models/branch_model.dart';
import 'package:topperspakistan/services/_services.dart';

class BranchService extends Service<BranchModel> {
  @override
  BranchModel parse(Map<String, dynamic> json) {
    return BranchModel.fromJson(json);
  }

  String get route => "branch";
}
