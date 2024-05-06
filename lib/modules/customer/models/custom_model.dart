// ignore_for_file: prefer_typing_uninitialized_variables

class CustomerList {
  var id;
  var name;
  var address;
  var lat;
  var long;
  var email;
  var mobile;
  var customerType;
  var customerStatus;
  var gpsRange;
  var salesmanId;
  var salesmanName;

  CustomerList(
      {this.id,
      this.name,
      this.address,
      this.lat,
      this.long,
      this.email,
      this.mobile,
      this.customerType,
      this.customerStatus,
      this.gpsRange,
      this.salesmanId,
      this.salesmanName});

  CustomerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    email = json['email'];
    mobile = json['mobile'];
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
    data['mobile'] = mobile;
    data['customer_type'] = customerType;
    data['customer_status'] = customerStatus;
    data['gps_range'] = gpsRange;
    data['salesman_id'] = salesmanId;
    data['salesman_name'] = salesmanName;
    return data;
  }
}
