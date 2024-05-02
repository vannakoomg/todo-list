class ProductModel {
  int? status;
  List<Product>? data;

  ProductModel({this.status, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
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

class Product {
  int? id;
  String? name;
  String? category;
  String? code;
  double? salePrice;
  String? productUom;
  int? productUomId;

  Product(
      {this.name,
      this.category,
      this.code,
      this.salePrice,
      this.id,
      this.productUom,
      this.productUomId});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    category = json['category'];
    code = json['code'];
    salePrice = json['sale_price'];
    productUom = json['product_uom'];
    productUomId = json['product_uom_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['category'] = category;
    data['code'] = code;
    data['sale_price'] = salePrice;
    data['product_uom'] = productUom;
    data['product_uom_id'] = productUomId;
    return data;
  }
}
