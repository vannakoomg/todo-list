import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';

import '../../../utils/widgets/custom_app.dart';
import '../../../utils/widgets/custom_buttom.dart';
import '../controller/check_in_controller.dart';

class CheckInNonCustomerScreen extends StatefulWidget {
  const CheckInNonCustomerScreen({super.key});

  @override
  State<CheckInNonCustomerScreen> createState() =>
      _CheckInNonCustomerScreenState();
}

class _CheckInNonCustomerScreenState extends State<CheckInNonCustomerScreen> {
  final controller = ChcekinController();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double lat = 0;
  double long = 0;
  @override
  void initState() {
    controller.fetchCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
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
                                    height: controller.isShowCustomer.value
                                        ? 250
                                        : 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    duration: const Duration(
                                      milliseconds: 250,
                                    ),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (!controller.isloading.value) {
                                              controller.isShowCustomer.value =
                                                  !controller
                                                      .isShowCustomer.value;
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 5),
                                            alignment: Alignment.centerLeft,
                                            color:
                                                controller.shopName.value == ""
                                                    ? AppColor.textThird
                                                    : const Color.fromARGB(
                                                        255, 138, 191, 138),
                                            height: 50,
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                controller.isloading.value &&
                                                        controller.customer
                                                                .value.data ==
                                                            null
                                                    ? const SizedBox(
                                                        height: 25,
                                                        width: 25,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: Text(
                                                          controller.shopName
                                                                      .value ==
                                                                  ""
                                                              ? "NA"
                                                              : controller
                                                                  .shopName
                                                                  .value,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                AnimatedRotation(
                                                  curve: Curves.easeInOutCirc,
                                                  duration: const Duration(
                                                      milliseconds: 250),
                                                  turns: controller
                                                          .isShowCustomer.value
                                                      ? -0.50
                                                      : 0,
                                                  child: const Icon(Icons
                                                      .keyboard_double_arrow_down_rounded),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child:
                                              controller.customer.value.data !=
                                                      null
                                                  ? SingleChildScrollView(
                                                      child: Column(
                                                        children: controller
                                                            .customer
                                                            .value
                                                            .data!
                                                            .asMap()
                                                            .entries
                                                            .map((e) {
                                                          return GestureDetector(
                                                            onTap: () async {
                                                              controller
                                                                  .onselected(
                                                                e.key,
                                                                e.value.name ??
                                                                    "",
                                                                double.parse(
                                                                    "${e.value.lat!}"),
                                                                double.parse(
                                                                    "${e.value.long!}"),
                                                                e.value.id ?? 0,
                                                              );
                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  () async {
                                                                final GoogleMapController
                                                                    mapcontroller =
                                                                    await _controller
                                                                        .future;
                                                                if (e.value
                                                                        .lat ==
                                                                    0) {
                                                                  await mapcontroller
                                                                      .moveCamera(
                                                                    CameraUpdate
                                                                        .newCameraPosition(
                                                                      CameraPosition(
                                                                        target: LatLng(
                                                                            double.parse("${e.value.lat!}"),
                                                                            double.parse("${e.value.long!}")),
                                                                        zoom:
                                                                            14.4746,
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  await mapcontroller
                                                                      .animateCamera(
                                                                    CameraUpdate
                                                                        .newCameraPosition(
                                                                      CameraPosition(
                                                                        target: LatLng(
                                                                            double.parse("${e.value.lat!}"),
                                                                            double.parse("${e.value.long!}")),
                                                                        zoom:
                                                                            14.4746,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: controller.selectIndex.value == e.key
                                                                          ? AppColor
                                                                              .secondnaryColor
                                                                          : Colors.green[
                                                                              50],
                                                                      border:
                                                                          Border(
                                                                        top:
                                                                            BorderSide(
                                                                          width:
                                                                              0.5,
                                                                          color: e.key == 0
                                                                              ? Colors.transparent
                                                                              : AppColor.secondnaryColor,
                                                                        ),
                                                                      )),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              height: 50,
                                                              width: double
                                                                  .infinity,
                                                              child: Text(
                                                                  "${e.value.name}"),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Address",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
                              ),
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
                                        border: Border.all(
                                            width: 0.8,
                                            color: AppColor.secondnaryColor),
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
                      controller.customer.value.data != null)
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
