// ignore_for_file: prefer_typing_uninitialized_variables

class OrderCustomModel {
  int? status;
  List<OrderCustomer>? data;

  OrderCustomModel({this.status, this.data});

  OrderCustomModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <OrderCustomer>[];
      json['data'].forEach((v) {
        data!.add(OrderCustomer.fromJson(v));
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

class OrderCustomer {
  int? id;
  String? name;
  String? address;
  var lat;
  var long;

  OrderCustomer({this.id, this.name, this.address, this.lat, this.long});

  OrderCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
