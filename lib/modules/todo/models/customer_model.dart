// ignore_for_file: prefer_typing_uninitialized_variables

class CustomerModel {
  int? status;
  List<Data>? data;

  CustomerModel({this.status, this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? address;
  var lat;
  var long;
  String? email;
  String? phone;
  String? customerType;
  String? customerStatus;
  double? gpsRange;
  var salesmanId;
  String? salesmanName;

  Data(
      {this.id,
      this.name,
      this.address,
      this.lat,
      this.long,
      this.email,
      this.phone,
      this.customerType,
      this.customerStatus,
      this.gpsRange,
      this.salesmanId,
      this.salesmanName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    email = json['email'];
    phone = json['phone'];
    customerType = json['customer_type'];
    customerStatus = json['customer_status'];
    gpsRange = json['gps_range'];
    salesmanId = json['salesman_id'];
    salesmanName = json['salesman_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['lat'] = lat;
    data['long'] = long;
    data['email'] = email;
    data['phone'] = phone;
    data['customer_type'] = customerType;
    data['customer_status'] = customerStatus;
    data['gps_range'] = gpsRange;
    data['salesman_id'] = salesmanId;
    data['salesman_name'] = salesmanName;
    return data;
  }
}
