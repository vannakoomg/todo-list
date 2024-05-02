import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import '../../../utils/fuction.dart';
import '../models/custom_address_model.dart';
import '../models/customer_model.dart';
import '../models/product_model.dart';
import '../models/sale_order_list_model.dart';

class OrderController extends GetxController {
  ScrollController scrollController = ScrollController();
  final order = <SaleOrderModel>[].obs;
  // final saleOrderlist = SaleOrderListModel().obs;
  final isloading = false.obs;
  final deliverDate = ''.obs;
  final currentPage = 0.obs;
  final lastpage = 0.obs;

  Future fetchSaleOrder(int page) async {
    isloading.value = true;
    await ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/sale_order_list?page=$page",
      methode: METHODE.get,
      isAuthorize: true,
    )
        .then((value) {
      // saleOrderlist.value = SaleOrderListModel.fromJson(value);
      debugPrint("fetch customer done ${value["data"].length}");
      lastpage.value = value["total_pages"];
      for (int i = 0; i < value["data"].length; ++i) {
        order.add(SaleOrderModel.fromJson(value["data"][i]));
      }
      isloading.value = false;
    }).onError((error, stackTrace) {
      isloading.value = false;

      debugPrint("fetch sale order history errooror $error");
    });
  }

  final deliveryAddressId = 0.obs;
  final deliverAddress = ''.obs;
  final customer = OrderCustomModel().obs;
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

  final customeraddress = CustomAddressModel().obs;

  List<Delivery> getSuggestionCustomAddress(String query) {
    List<Delivery> matches = [];
    matches.addAll(customeraddress.value.data!);
    matches.retainWhere((location) =>
        location.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  void fetchCustomer() async {
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/fetch_customer",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      customer.value = OrderCustomModel.fromJson(value);
      debugPrint("customer ${customer.value.data!.length}");
    });
  }

  final product = ProductModel().obs;
  void fetchProduct() async {
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/product_list",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      debugPrint("product $value");
      product.value = ProductModel.fromJson(value);
    }).onError((error, stackTrace) {
      debugPrint("you have error");
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
}
