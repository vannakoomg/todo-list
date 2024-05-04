import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/order/controller/create_order_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';

import '../../../utils/fuction.dart';
import '../../../utils/widgets/custom_app.dart';
import '../../../utils/widgets/custom_buttom.dart';
import '../../../utils/widgets/custom_search_selecte.dart';
import '../../../utils/widgets/custom_texfiled.dart';
import '../../order/models/customer_model.dart';
import '../controller/check_in_controller.dart';

class CheckInNonCustomerScreen extends StatefulWidget {
  const CheckInNonCustomerScreen({super.key});

  @override
  State<CheckInNonCustomerScreen> createState() =>
      _CheckInNonCustomerScreenState();
}

class _CheckInNonCustomerScreenState extends State<CheckInNonCustomerScreen> {
  final controller = ChcekinController();
  final ordercontroller = CreateOrderController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double lat = 0;
  double long = 0;
  @override
  void initState() {
    ordercontroller.fetchCustomer('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppBar(title: "Check In"),
        body: Obx(
          () => Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 20),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shop Name",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Stack(
                                children: [
                                  AnimatedContainer(
                                    curve: Curves.easeInOutCirc,
                                    clipBehavior: Clip.antiAlias,
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    duration: const Duration(
                                      milliseconds: 250,
                                    ),
                                    child: Column(
                                      children: [
                                        TypeAheadField<OrderCustomer?>(
                                          controller: TextEditingController(
                                            text: controller.shopName.value,
                                          ),
                                          emptyBuilder: (context) => Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              'Not found!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: AppColor.danger),
                                            ),
                                          ),
                                          suggestionsCallback: (pattern) async {
                                            return ordercontroller
                                                .getSuggestions(pattern);
                                          },
                                          builder: (context, controller1,
                                              focusNode) {
                                            return CustomTextfiled(
                                              onChanged: (value) {
                                                ordercontroller
                                                    .fetchCustomer(value);
                                              },
                                              controller: controller1,
                                              hintText: "",
                                              focusNode: focusNode,
                                              suffixIcon: const Icon(
                                                Icons.arrow_downward_rounded,
                                              ),
                                            );
                                          },
                                          itemBuilder: (context,
                                              OrderCustomer? suggestion) {
                                            if (suggestion == null) {
                                              return const SizedBox.shrink();
                                            }
                                            final index = ordercontroller
                                                .customer.value.data!
                                                .indexOf(suggestion);
                                            return CustomSearchSelect(
                                              index: index,
                                              title: "${suggestion.name}",
                                            );
                                          },
                                          onSelected:
                                              (OrderCustomer? value) async {
                                            controller.shopName.value =
                                                value!.name!;
                                            controller.paraterId.value =
                                                value.id!;
                                            debugPrint(
                                                "${value.lat}${value.long}");
                                            controller.onselected(
                                              value.id!,
                                              value.name ?? "",
                                              double.parse("${value.lat!}"),
                                              double.parse("${value.long!}"),
                                              value.id ?? 0,
                                            );
                                            final GoogleMapController
                                                mapcontroller =
                                                await _controller.future;
                                            if (value.lat == 0) {
                                              await mapcontroller.moveCamera(
                                                CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                    target: LatLng(
                                                        double.parse(
                                                            "${value.lat!}"),
                                                        double.parse(
                                                            "${value.long!}")),
                                                    zoom: 14.4746,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              await mapcontroller.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                    target: LatLng(
                                                        double.parse(
                                                            "${value.lat!}"),
                                                        double.parse(
                                                            "${value.long!}")),
                                                    zoom: 14.4746,
                                                  ),
                                                ),
                                              );
                                            }

                                            unFocus();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text("Address",
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              const Gap(10),
                              Text(
                                controller.address.value == ""
                                    ? "Not Found"
                                    : controller.address.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.shopLat.value != 0) {
                                    controller.showMapDetail(
                                        context,
                                        controller.shopLat.value,
                                        controller.shopLong.value,
                                        "");
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 200,
                                      child: GoogleMap(
                                        mapType: MapType.normal,
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                controller.shopLat.value,
                                                controller.shopLong.value),
                                            zoom: 14.23),
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          _controller.complete(controller);
                                        },
                                        zoomControlsEnabled: false,
                                        myLocationEnabled: true,
                                        mapToolbarEnabled: false,
                                        myLocationButtonEnabled: false,
                                        markers: const {},
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: controller.shopLat.value != 0
                                            ? const Icon(
                                                Icons.location_on_sharp,
                                                color: Color.fromARGB(
                                                    255, 236, 40, 105),
                                                size: 35,
                                              )
                                            : const Text("Not Found"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomButtom(
                        white: 120,
                        disble: controller.shopName.value == "" ? true : false,
                        title: "CHECK IN",
                        onTap: () async {
                          controller.checkinNewCustomer(context);
                        },
                      )
                    ],
                  ),
                  if (controller.isloading.value &&
                      ordercontroller.customer.value.data != null)
                    Expanded(
                        child: Container(
                      color: Colors.transparent,
                      child: const Center(
                        child: CustomLoading(),
                      ),
                    ))
                ],
              )),
        ));
  }
}
