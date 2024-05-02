// ignore_for_file: non_constant_identifier_names

class OrderModel {
  int? qty;
  String? name;
  double? price;
  int? discount;
  int? foc;
  OrderModel({
    required this.qty,
    required this.foc,
    required this.name,
    required this.discount,
    required this.price,
  });
}

class OrderLinesss {
  int? product_id;
  int? product_uom_qty;
  int? product_uom;
  double? price_unit;
  int? foc;
  int? discount;

  OrderLinesss({
    this.discount,
    this.price_unit,
    this.product_id,
    this.product_uom,
    this.product_uom_qty,
    this.foc,
  });

  // Returns a custom-formatted string resembling a dictionary
  String toFormattedString() {
    return "{'product_id': $product_id, 'product_uom_qty': $product_uom_qty, 'product_uom': $product_uom, 'price_unit': $price_unit, 'discount': $discount, 'foc':$foc}";
  }
}
