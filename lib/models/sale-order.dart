import 'package:topperspakistan/models/_model.dart';
import 'package:topperspakistan/models/branch_model.dart';
import 'package:topperspakistan/models/customer_model.dart';
import 'package:topperspakistan/models/item_model.dart';
import 'package:topperspakistan/models/sale-order-item_model.dart';

import 'address_model.dart';

class SaleOrder extends Model {
  int id;
  String invoiceDate;
  String invoiceId;
  int customerId;
  int addressId;
  int branchId;
  String paymentType;
  String billingAddress;
  String amount;
  String deliveryStatus;
  String origin;
  int delivery;
  int discount;
  String instructions;
  int balanceDue;
  String returnStatus;
  String createdAt;
  String updatedAt;
  CustomerModel customer;
  BranchModel branch;
  AddressModel address;
  List<MyItem> items;
  int deliveryFee;

  SaleOrder(
      {this.id,
        this.invoiceDate,
        this.invoiceId,
        this.customerId,
        this.addressId,
        this.branchId,
        this.paymentType,
        this.billingAddress,
        this.amount,
        this.deliveryStatus,
        this.origin,
        this.delivery,
        this.discount,
        this.instructions,
        this.balanceDue,
        this.returnStatus,
        this.createdAt,
        this.updatedAt,
        this.customer,
        this.branch,
        this.address,
        this.items,
        this.deliveryFee
      });

  SaleOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceDate = json['invoice_date'];
    invoiceId = json['invoice_id'];
    customerId = json['customer_id'];
    addressId = json['address_id'];
    branchId = json['branch_id'];
    paymentType = json['payment_type'];
    billingAddress = json['billing_address'];
    amount = json['amount'];
    deliveryStatus = json['delivery_status'];
    origin = json['origin'];
    delivery = json['delivery'];
    discount =  int.tryParse(json['discount'].toString()) ?? 0;
    deliveryFee =  int.tryParse(json['delivery_fee'].toString()) ?? 0;
    instructions = json['instructions'];
    balanceDue = int.tryParse(json['balance_due'].toString()) ?? 0;
    returnStatus = json['return_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null ? new CustomerModel.fromJson(json['customer']) : null;
    branch =
    json['branch'] != null ? new BranchModel.fromJson(json['branch']) : null;
    address =
    json['address'] != null ? new AddressModel.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoiceDate'] = this.invoiceDate;
    data['invoiceNumber'] = this.invoiceId;
    data['customer'] = this.customerId;
    data['address_id'] = this.addressId;
    data['branchId'] = this.branchId;
    data['type'] = this.paymentType;
    data['billingAddress'] = this.billingAddress;
    data['amount'] = this.amount;
    data['delivery_status'] = this.deliveryStatus;
    data['origin'] = this.origin;
    data['delivery'] = this.delivery;
    data['delivery_fee'] = this.deliveryFee;
    data['discount'] = this.discount;
    data['instruction'] = this.instructions;
    data['balance'] = this.balanceDue;
    data['return_status'] = this.returnStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyItem {
  SaleOrderItem item;

  MyItem({this.item});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    return data;
  }
}