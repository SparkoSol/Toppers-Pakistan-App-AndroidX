import '_model.dart';

class OrderModel extends Model {
  String customerId;
  String addressId;
  String branchId;
  String status;
  String instruction;
  String timeCreated;
  int totatlPrice;

  OrderModel(
      {int id, this.branchId, this.addressId, this.customerId, this.status, this.instruction, this.totatlPrice,this.timeCreated})
      : super(id: id);

  OrderModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            status: json['status'],
            customerId: json['customer_id'].toString(),
            addressId: json['address_id'].toString(),
            branchId: json['branch_id'].toString(),
            totatlPrice: json['total_price'],
            instruction: json['instruction'],
            timeCreated: json['created_at']
            );

  @override
  Map<String, dynamic> toJson() => {
        'status': status,
        'customer_id': customerId,
        'address_id': addressId,
        'branch_id': branchId,
        'total_price': totatlPrice,
        'instruction':instruction
      };
}
