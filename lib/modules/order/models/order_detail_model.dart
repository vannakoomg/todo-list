class OrderDetailModel {
  int? status;
  Data? data;

  OrderDetailModel({this.status, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? partnerId;
  String? dateOrder;
  String? deliveryDate;
  double? globalDiscount;
  String? partnerName;
  double? amount;
  int? deliveryAddressId;
  String? deliveryAddress;
  String? note;

  List<OrderLines>? orderLines;

  Data(
      {this.id,
      this.name,
      this.partnerId,
      this.dateOrder,
      this.deliveryDate,
      this.globalDiscount,
      this.partnerName,
      this.amount,
      this.deliveryAddressId,
      this.deliveryAddress,
      this.note,
      this.orderLines});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    partnerId = json['partner_id'];
    dateOrder = json['date_order'];
    deliveryDate = json['delivery_date'];
    globalDiscount = json['global_discount'];
    partnerName = json['partner_name'];
    amount = json['amount'];
    deliveryAddressId = json['delivery_address_id'];
    deliveryAddress = json['delivery_address'];
    note = json['note'];
    if (json['order_lines'] != null) {
      orderLines = <OrderLines>[];
      json['order_lines'].forEach((v) {
        orderLines!.add(OrderLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['partner_id'] = partnerId;
    data['date_order'] = dateOrder;
    data['delivery_date'] = deliveryDate;
    data['global_discount'] = globalDiscount;
    data['partner_name'] = partnerName;
    data['amount'] = amount;
    data['delivery_address_id'] = deliveryAddressId;
    data['delivery_address'] = deliveryAddress;
    data['note'] = note;
    if (orderLines != null) {
      data['order_lines'] = orderLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderLines {
  String? productName;
  int? productId;
  double? productUomQty;
  int? productUom;
  double? priceUnit;
  double? foc;
  double? discount;

  OrderLines(
      {this.productName,
      this.productId,
      this.foc,
      this.productUomQty,
      this.productUom,
      this.priceUnit,
      this.discount});

  OrderLines.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productId = json['product_id'];
    productUomQty = json['product_uom_qty'];
    productUom = json['product_uom'];
    priceUnit = json['price_unit'];
    discount = json['discount'];
    foc = json['foc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['product_id'] = productId;
    data['product_uom_qty'] = productUomQty;
    data['product_uom'] = productUom;
    data['foc'] = foc;
    data['price_unit'] = priceUnit;
    data['discount'] = discount;
    return data;
  }
}
