import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/modules/order/controller/order_controller.dart';
import 'package:googlemap_ui/modules/order/models/customer_model.dart';
import 'package:googlemap_ui/modules/order/models/order_detail_model.dart';
import 'package:googlemap_ui/modules/order/models/order_model.dart';
import 'package:googlemap_ui/modules/order/models/product_model.dart';
import 'package:googlemap_ui/modules/order/models/sale_order_list_model.dart';
import 'package:googlemap_ui/utils/context_unitity.dart';
import 'package:googlemap_ui/utils/widgets/custom_alert.dart';

import '../../../utils/fuction.dart';
import '../models/custom_address_model.dart';

class CreateOrderController extends GetxController {
  final orderController = Get.put(OrderController());
  final orderIndex = 0.obs;
  final orderDate = ''.obs;
  final deliverDate = ''.obs;
  final customName = "".obs;
  final customerId = 0.obs;
  final deliveryAddressId = 0.obs;
  final deliverAddress = ''.obs;
  final productName = ''.obs;
  final productId = 0.obs;
  final productUom = 0.obs;
  final discountTotal = '0'.obs;
  final discountTotalText = TextEditingController(text: "0").obs;
  final qty = ''.obs;
  final discount = ''.obs;
  final qtyText = TextEditingController().obs;
  final priceText = TextEditingController().obs;
  final discountText = TextEditingController().obs;
  final remake = ''.obs;
  final remakeText = TextEditingController().obs;
  final foc = ''.obs;
  final focText = TextEditingController().obs;

  final customer = OrderCustomModel().obs;
  // final customList = <CustomerModel>[].obs;

  List<OrderCustomer> getSuggestions(String query) {
    List<OrderCustomer> matches = [];
    matches.addAll(customer.value.data!);
    matches.retainWhere((location) =>
        location.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<Product> getSuggestionProduct(String query) {
    List<Product> matches = [];
    matches.addAll(product.value.data!);
    matches.retainWhere((location) =>
        location.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<Delivery> getSuggestionCustomAddress(String query) {
    List<Delivery> matches = [];
    matches.addAll(customeraddress.value.data!);
    matches.retainWhere((location) =>
        location.name!.toLowerCase().contains(query.toLowerCase()));
    debugPrint("matches : $matches");
    return matches;
  }

  Future fetchCustomer(String text) async {
    // isloading.value = true;
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/customer/search?q=$text",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      debugPrint("customer list done ");
      customer.value = OrderCustomModel.fromJson(value);
    }).onError((error, stackTrace) {
      CustomDialog.error(
          title: "Error",
          message: "Something went wrong",
          bottonTitle: "Try again",
          ontap: () {
            fetchProduct('');
            fetchCustomer('');
            Navigator.of(ContextUtility.context!, rootNavigator: true)
                .popUntil((route) => route is! PopupRoute);
          });
    });
  }

  final product = ProductModel().obs;
  Future fetchProduct(String text) async {
    await ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/product_list?$text",
      methode: METHODE.get,
      isAuthorize: true,
    )
        .then((value) {
      debugPrint("product done");
      product.value = ProductModel.fromJson(value);
    }).onError((error, stackTrace) {
      debugPrint("error :$error");
      CustomDialog.error(
          title: "Error",
          message: "Something went wrong",
          bottonTitle: "Try again",
          ontap: () {
            fetchProduct('');
            fetchCustomer('');
            Navigator.of(ContextUtility.context!, rootNavigator: true)
                .popUntil((route) => route is! PopupRoute);
          });
    });
  }

  void selectDeliveryDate(BuildContext context) async {
    DateTime? time = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030, 2, 2),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
                primary: Colors.black,
                background: Colors.white,
              ),
            ),
            child: child!,
          );
        });
    if (time != null) {
      deliverDate.value = formatDate(time);
    }
  }

  // for order
  final order = <OrderModel>[].obs;
  final customeraddress = CustomAddressModel().obs;
  final subTotal = 0.0.obs;

  double getTotal() {
    int discon = discountTotal.value == "" ? 0 : int.parse(discountTotal.value);
    return subTotal * (1 - discon / 100);
  }

  bool checkButton() {
    if (subTotal.value != 0 &&
        customName.value != "" &&
        deliverAddress.value != "") {
      return false;
    } else {
      return true;
    }
  }

  void createOrder() async {
    debugPrint("value ${remake.value}");
    isloading.value = true;
    String orderlingString =
        '[${orderline.map((item) => item.toFormattedString()).join(', ')}]';
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url:
          "/ppm_sale/api/sale_order/new?partner_id=${customerId.value}&date_order=${orderDate.value}&commitment_date=${deliverDate.value}&company_id=1&partner_shipping_id=${deliveryAddressId.value}&pricelist_id=1&validity_date=2024-05-06&global_discount=${discountTotal.value}&note=${remake.value}&order_lines=$orderlingString",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      // debugPrint("value $value");
      orderController.order.insert(
        0,
        SaleOrderModel(
          amount: subTotal.value,
          dateOrder: orderDate.value,
          deliveryDate: deliverDate.value,
          name: "",
          partnerId: customerId.value,
          deliveryAddressId: deliveryAddressId.value,
          partnerName: customName.value,
          deliveryAddress: deliverAddress.value,
          status: "draft",
          id: value["data"]["order_id"],
        ),
      );
      orderController.obs.refresh();

      CustomDialog.success(
          barrierDismissible: false,
          message: "Your Have Create New Order Success",
          title: "Success",
          ontap: () {
            Get.back();
            Get.back();
            clearAllData();
          });
      isloading.value = false;
    }).onError((error, stackTrace) {
      CustomDialog.success(
          barrierDismissible: false,
          message: "Error",
          title: "$error",
          ontap: () {
            Get.back();
            Get.back();
            clearAllData();
          });
    });
  }

  void updateOrder(int id) async {
    debugPrint("order note  ${remake.value}");
    // debugPrint("orderline ${orderDate.value}");

    isloading.value = true;
    String orderlingString =
        '[${orderline.map((item) => item.toFormattedString()).join(', ')}]';
    debugPrint("orderline $orderlingString");
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url:
          "/ppm_sale/api/sale_order/update?order_id=$id&partner_id=${customerId.value}&date_order=${orderDate.value}&commitment_date=${deliverDate.value}&company_id=1&partner_shipping_id=${deliveryAddressId.value}&pricelist_id=1&validity_date=2024-05-06&global_discount=${discountTotal.value}&note=${remake.value}&order_lines=$orderlingString",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      isloading.value = false;

      debugPrint("value $value");
      orderController.order[orderIndex.value].partnerName = customName.value;
      orderController.order[orderIndex.value].partnerId = customerId.value;
      orderController.order[orderIndex.value].deliveryAddress =
          deliverAddress.value;
      orderController.order[orderIndex.value].deliveryAddressId =
          deliveryAddressId.value;
      orderController.order[orderIndex.value].dateOrder = orderDate.value;
      orderController.order[orderIndex.value].deliveryDate = deliverDate.value;
      orderController.order.refresh();
      CustomDialog.success(
          barrierDismissible: false,
          message: "Updated Order Success",
          title: "Success",
          ontap: () {
            Get.back();
            Get.back();
            clearAllData();
          });
    }).onError((error, stackTrace) {
      debugPrint("jjjjjj $error");
    });
  }

  Future fetchCustomerAddress(int customerId) async {
    customeraddress.value = CustomAddressModel();
    await ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/customer/delivery_address?partner_id=$customerId",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      customeraddress.value = CustomAddressModel.fromJson(value);
      customeraddress.refresh();
    }).onError((error, stackTrace) {
      debugPrint("on error $error");
    });
  }

  final orderline = <OrderLinesss>[].obs;
  void addOrder() {
    // unFocus();
    double p = 10;
    int d = discount.value == "" ? 0 : int.parse(discount.value);
    int f = foc.value == "" ? 0 : int.parse(foc.value);
    int q = int.parse(qty.value);
    subTotal.value = subTotal.value + (p * q) * (1 - d / 100);
    order.add(
      OrderModel(
        discount: d,
        name: productName.value,
        price: p,
        qty: q,
        foc: f,
      ),
    );
    orderline.add(
      OrderLinesss(
          discount: d,
          price_unit: p,
          product_id: productId.value,
          product_uom: productUom.value,
          product_uom_qty: q,
          foc: f),
    );
    productName.value = "";
    qty.value = "";
    qtyText.value.text = "";
    priceText.value.text = "";
    discount.value = "";
    discountText.value.text = "";
    foc.value = "";
    focText.value.text = '';
  }

  void deleteProduct(int index) {
    double price = order[index].price!.toDouble();
    double qty = order[index].qty!.toDouble();
    double discount = order[index].discount!.toDouble();
    subTotal.value = subTotal.value - (qty * price) * (1 - discount / 100);
    order.removeAt(index);
    orderline.removeAt(index);
  }

  void clearAllData() {
    customName.value = "";
    deliverAddress.value = "";
    remake.value = "";
    remakeText.value.text = "";
    discountText.value.text = "";
    order.clear();
    orderline.clear();
    subTotal.value = 0;
    discountTotal.value = "0";
  }

  final orderDetail = OrderDetailModel().obs;
  final isloading = false.obs;
  Future fetchOrderDetail(int id) async {
    isloading.value = true;
    await ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/sale_order_detail?order_id=$id",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      isloading.value = false;
      orderDetail.value = OrderDetailModel.fromJson(value);
      orderDate.value = orderDetail.value.data!.dateOrder!;
      deliverDate.value = orderDetail.value.data!.deliveryDate!;
      customName.value = orderDetail.value.data!.partnerName!;
      customerId.value = orderDetail.value.data!.partnerId!;
      remake.value = orderDetail.value.data!.note!;
      remakeText.value.text = orderDetail.value.data!.note!;
      discountTotal.value =
          orderDetail.value.data!.globalDiscount!.toInt().toString();
      discountTotalText.value =
          TextEditingController(text: discountTotal.value);
      deliverAddress.value = orderDetail.value.data!.deliveryAddress!;
      deliveryAddressId.value = orderDetail.value.data!.deliveryAddressId!;
      fetchCustomerAddress(deliveryAddressId.value);
      for (var value in orderDetail.value.data!.orderLines!) {
        order.add(
          OrderModel(
            foc: value.foc!.toInt(),
            qty: value.productUomQty!.toInt(),
            name: value.productName,
            discount: value.discount!.toInt(),
            price: value.priceUnit,
          ),
        );
        debugPrint("-------------${value.foc!.toInt()}");
        orderline.add(
          OrderLinesss(
            discount: value.discount!.toInt(),
            price_unit: value.priceUnit,
            product_id: value.productId,
            product_uom: value.productUom,
            product_uom_qty: value.productUomQty!.toInt(),
            foc: value.foc!.toInt(),
          ),
        );
        subTotal.value = subTotal.value +
            (value.priceUnit! * value.productUomQty!) *
                (1 - value.discount! / 100);
        debugPrint("order line $orderline");
      }
    }).onError((error, stackTrace) {
      isloading.value = false;
      debugPrint("on error $error");
    });
  }

  Future searchCustomer(String text) async {
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
          url: "/ppm_sale/api/customer/search?q=$text",
          methode: METHODE.get,
          isAuthorize: true,
        )
        .then((value) {});
  }
}
