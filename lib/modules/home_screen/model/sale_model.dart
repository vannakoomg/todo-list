// ignore_for_file: prefer_typing_uninitialized_variables

class SaleModel {
  int? status;
  List<Data>? data;

  SaleModel({this.status, this.data});

  SaleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? customerName;
  int? partnerId;
  int? userId;
  String? todoDate;
  String? checkInDate;
  String? checkOutDate;
  String? status;
  String? address;
  String? customerCode;
  double? lat;
  double? long;
  var photo;
  String? photoLat;
  String? photoLong;
  bool? hasOrder;
  String? remark;

  Data(
      {this.id,
      this.customerName,
      this.partnerId,
      this.userId,
      this.todoDate,
      this.checkInDate,
      this.checkOutDate,
      this.status,
      this.address,
      this.customerCode,
      this.lat,
      this.long,
      this.photo,
      this.photoLat,
      this.photoLong,
      this.hasOrder,
      this.remark});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    partnerId = json['partner_id'];
    userId = json['user_id'];
    todoDate = json['todo_date'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    status = json['status'];
    address = json['address'];
    customerCode = json['customer_code'];
    lat = json['lat'];
    long = json['long'];
    photo = json['photo'];
    photoLat = json['photo_lat'];
    photoLong = json['photo_long'];
    hasOrder = json['has_order'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_name'] = customerName;
    data['partner_id'] = partnerId;
    data['user_id'] = userId;
    data['todo_date'] = todoDate;
    data['check_in_date'] = checkInDate;
    data['check_out_date'] = checkOutDate;
    data['status'] = status;
    data['address'] = address;
    data['customer_code'] = customerCode;
    data['lat'] = lat;
    data['long'] = long;
    data['photo'] = photo;
    data['photo_lat'] = photoLat;
    data['photo_long'] = photoLong;
    data['has_order'] = hasOrder;
    data['remark'] = remark;
    return data;
  }
}
