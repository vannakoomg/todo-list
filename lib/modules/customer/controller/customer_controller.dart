import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/modules/customer/models/custom_model.dart';
import 'package:googlemap_ui/modules/customer/models/customer_type_model.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_alert.dart';

import '../../todo/screen/map_detail.dart';

class CustomerController extends GetxController {
  final custom = <CustomerList>[].obs;
  ScrollController scrollController = ScrollController();
  final currentPage = 0.obs;
  final lastpage = 0.obs;
  void fetchCustomer(int page) async {
    isloading.value = true;
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/fetch_customer?page=$page",
      methode: METHODE.get,
      isAuthorize: true,
    )
        .then((value) {
      debugPrint("fetch customer done ${value["data"].length}");
      lastpage.value = value["total_pages"];
      for (int i = 0; i < value["data"].length; ++i) {
        custom.add(CustomerList.fromJson(value["data"][i]));
      }
      isloading.value = false;
    }).onError((error, stackTrace) {
      isloading.value = false;
      debugPrint("fetch customer error $error");
    });
  }

  final currentlat = 0.0.obs;
  final currentlng = 0.0.obs;
  final mapController = Completer<GoogleMapController>().obs;
  Future getCurrentLocation() async {
    if (currentlat.value == 0) {
      Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentlat.value = location.latitude;
      currentlng.value = location.longitude;
      // currentlat.value = 11.561278778328456;
      // currentlng.value = 104.92615608061244;
    }
  }

  Future showMapDetail(
    BuildContext context,
    double lat,
    double long,
    String title,
    Function ontap,
  ) async {
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.95,
          child: MapDetail(
            lat: lat,
            long: long,
            title: title,
            isSeletcLocation: true,
            ontap: (value) async {
              CameraPosition position = value;
              currentlat.value = position.target.latitude;
              currentlng.value = position.target.longitude;
              ontap();
            },
          ),
        );
      },
    );
  }

  //fetch customer type

  final customerType = CustomerTypeModel().obs;
  Future fetchCustomerType() async {
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/customer_type",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      customerType.value = CustomerTypeModel.fromJson(value);
      debugPrint("fetch customer type done $value");
    }).onError((error, stackTrace) {
      debugPrint("fetch customer type on error ");
    });
  }

  List<CustomerType> getSuggestionCustomerType(String query) {
    List<CustomerType> matches = [];
    matches.addAll(customerType.value.data!);
    matches.retainWhere((location) =>
        location.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  // create new customer
  final customerName = "".obs;
  final customerNameText = TextEditingController().obs;
  final phone = "".obs;
  final phoneText = TextEditingController().obs;
  final address = "".obs;
  final addressText = TextEditingController().obs;
  final gmailAddress = "".obs;
  final gmailAddressText = TextEditingController().obs;
  final typeName = ''.obs;

  final customeraddress = "".obs;
  final lat = "".obs;
  final long = "".obs;
  final type = 0.obs;
  final isloading = false.obs;

  Future createCusomter() async {
    isloading.value = true;
    unFocus();
    await ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url:
          "/ppm_sale/api/customer/new?partner_longitude=${currentlng.value}&partner_latitude=${currentlat.value}&email=${gmailAddress.value}&customer_address=${address.value}&name=${customerName.value}&customer_type=${type.value}&phone=${phone.value}",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      isloading.value = false;
      custom.insert(
        0,
        CustomerList(
          name: customerName.value,
          phone: phone.value,
          address: address.value,
          email: gmailAddress.value,
          customerType: typeName.value,
        ),
      );
      custom.refresh();
      CustomDialog.success(
          barrierDismissible: false,
          title: "Success",
          message: "Create New Customer Success",
          ontap: () {
            Get.back();
            Get.back();
            clearCustomer();
          });
    }).onError((error, stackTrace) {
      debugPrint("you have been on error ");
    });
  }

  void clearCustomer() {
    customerName.value = '';
    customerNameText.value.text = "";
    typeName.value = "";
    type.value = 0;
    phone.value = "";
    phoneText.value.text = "";
    gmailAddress.value = '';
    gmailAddressText.value.text = "";
    address.value = '';
    addressText.value.text = "";
  }

  bool checkButton() {
    if (customerName.value != "" &&
        type.value != 0 &&
        phone.value != "" &&
        address.value != "" &&
        gmailAddress.value != "") {
      return false;
    }
    return true;
  }
}
