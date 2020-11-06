class Variant {
  int active;
  int id;
  int itemId;
  String name;
  int purchasePrice;
  int salePrice;
  int stock;
  int stockValue;

  Variant(
      {this.active,
        this.id,
        this.itemId,
        this.name,
        this.purchasePrice,
        this.salePrice,
        this.stock,
        this.stockValue});

  Variant.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    id = json['id'];
    itemId = json['item_id'];
    name = json['name'];
    purchasePrice = json['purchase_price'];
    salePrice = json['sale_price'];
    stock = json['stock'];
    stockValue = json['stock_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['purchase_price'] = this.purchasePrice;
    data['sale_price'] = this.salePrice;
    data['stock'] = this.stock;
    data['stock_value'] = this.stockValue;
    return data;
  }
}
