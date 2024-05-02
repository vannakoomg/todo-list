class SaleOrderListModel {
  int? status;
  List<SaleOrderModel>? data;

  SaleOrderListModel({this.status, this.data});

  SaleOrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SaleOrderModel>[];
      json['data'].forEach((v) {
        data!.add(SaleOrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleOrderModel {
  int? id;
  String? name;
  int? partnerId;
  String? dateOrder;
  String? deliveryDate;
  String? partnerName;
  double? amount;
  String? status;
  int? deliveryAddressId;
  String? deliveryAddress;

  SaleOrderModel(
      {this.id,
      this.name,
      this.partnerId,
      this.dateOrder,
      this.deliveryDate,
      this.partnerName,
      this.amount,
      this.status,
      this.deliveryAddressId,
      this.deliveryAddress});

  SaleOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    partnerId = json['partner_id'];
    dateOrder = json['date_order'];
    deliveryDate = json['delivery_date'];
    partnerName = json['partner_name'];
    amount = json['amount'];
    status = json['status'];
    deliveryAddressId = json['delivery_address_id'];
    deliveryAddress = json['delivery_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['partner_id'] = partnerId;
    data['date_order'] = dateOrder;
    data['delivery_date'] = deliveryDate;
    data['partner_name'] = partnerName;
    data['amount'] = amount;
    data['status'] = status;
    data['delivery_address_id'] = deliveryAddressId;
    data['delivery_address'] = deliveryAddress;
    return data;
  }
}
