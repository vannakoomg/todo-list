class SaleListModel {
  String? jsonrpc;
  Result? result;

  SaleListModel({this.jsonrpc, this.result});

  SaleListModel.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonrpc'] = jsonrpc;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Data>? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? visitCycle;
  bool? monDay;
  bool? tueDay;
  bool? wedDay;
  bool? thuDay;
  bool? friDay;
  bool? satDay;
  SaleManId? saleManId;
  Customer? customer;

  Data(
      {this.id,
      this.name,
      this.visitCycle,
      this.monDay,
      this.tueDay,
      this.wedDay,
      this.thuDay,
      this.friDay,
      this.satDay,
      this.saleManId,
      this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    visitCycle = json['visit_cycle'];
    monDay = json['mon_day'];
    tueDay = json['tue_day'];
    wedDay = json['wed_day'];
    thuDay = json['thu_day'];
    friDay = json['fri_day'];
    satDay = json['sat_day'];
    saleManId = json['sale_man_id'] != null
        ? SaleManId.fromJson(json['sale_man_id'])
        : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['visit_cycle'] = visitCycle;
    data['mon_day'] = monDay;
    data['tue_day'] = tueDay;
    data['wed_day'] = wedDay;
    data['thu_day'] = thuDay;
    data['fri_day'] = friDay;
    data['sat_day'] = satDay;
    if (saleManId != null) {
      data['sale_man_id'] = saleManId!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class SaleManId {
  int? id;
  String? name;
  String? phone;
  Leader? leader;

  SaleManId({this.id, this.name, this.phone, this.leader});

  SaleManId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    leader = json['leader'] != null ? Leader.fromJson(json['leader']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    if (leader != null) {
      data['leader'] = leader!.toJson();
    }
    return data;
  }
}

class Leader {
  int? id;
  String? name;

  Leader({this.id, this.name});

  Leader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? address;
  double? late;
  double? long;

  Customer({this.id, this.name, this.address, this.late, this.long});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    late = json['late'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['late'] = late;
    data['long'] = long;
    return data;
  }
}
