import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_ui/modules/customer/controller/customer_controller.dart';
import 'package:googlemap_ui/modules/customer/models/customer_type_model.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';
import 'package:googlemap_ui/utils/widgets/custom_texfiled.dart';

import '../../../config/const/app_colors.dart';
import '../../../utils/fuction.dart';
import '../../../utils/widgets/custom_search_selecte.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  final controller = Get.put(CustomerController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  void initState() {
    controller.fetchCustomerType();
    controller.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Add New Customer",
        ),
        body: Obx(
          () => Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: CustomTextfiled(
                                        controller:
                                            controller.customerNameText.value,
                                        hintText: "Name",
                                        onChanged: (value) {
                                          controller.customerName.value = value;
                                        },
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TypeAheadField<CustomerType?>(
                                      controller: TextEditingController(
                                        text: controller.typeName.value,
                                      ),
                                      emptyBuilder: (context) => Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Not found!',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColor.danger),
                                        ),
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        return controller
                                            .getSuggestionCustomerType(pattern);
                                      },
                                      builder:
                                          (context, controller1, focusNode) {
                                        return CustomTextfiled(
                                          controller: controller1,
                                          hintText: "",
                                          focusNode: focusNode,
                                          suffixIcon: const Icon(
                                            Icons.arrow_downward_rounded,
                                          ),
                                        );
                                      },
                                      itemBuilder:
                                          (context, CustomerType? suggestion) {
                                        if (suggestion == null) {
                                          return const SizedBox.shrink();
                                        }
                                        final index = controller
                                            .customerType.value.data!
                                            .indexOf(suggestion);
                                        return CustomSearchSelect(
                                          index: index,
                                          title: "${suggestion.name}",
                                        );
                                      },
                                      onSelected: (CustomerType? value) {
                                        controller.typeName.value =
                                            value!.name!;
                                        controller.type.value = value.id!;
                                        unFocus();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                            CustomTextfiled(
                              controller: controller.phoneText.value,
                              hintText: "Phone number",
                              onChanged: (value) {
                                controller.phone.value = value;
                              },
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                            ),
                            const Gap(20),
                            CustomTextfiled(
                              controller: controller.addressText.value,
                              hintText: "Address",
                              onChanged: (value) {
                                controller.address.value = value;
                              },
                            ),
                            const Gap(20),
                            CustomTextfiled(
                              controller: controller.gmailAddressText.value,
                              hintText: "Email address",
                              onChanged: (value) {
                                controller.gmailAddress.value = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const Gap(20),
                            GestureDetector(
                              onTap: () {
                                controller.showMapDetail(
                                    context,
                                    controller.currentlat.value,
                                    controller.currentlng.value,
                                    controller.address.value, () async {
                                  final GoogleMapController mcontroller =
                                      await _controller.future;
                                  await mcontroller.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                    target: LatLng(
                                      controller.currentlat.value,
                                      controller.currentlng.value,
                                    ),
                                    zoom: 14.4746,
                                  )));
                                }).then(
                                  (value) => {debugPrint("")},
                                );
                              },
                              child: SizedBox(
                                height: 200,
                                child: Stack(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        // color: AppColor.secondnaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      height: 200,
                                      child: AbsorbPointer(
                                        absorbing: true,
                                        child: GoogleMap(
                                          mapType: MapType.normal,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                controller.currentlat.value,
                                                controller.currentlng.value),
                                            zoom: 14.23,
                                          ),
                                          onMapCreated:
                                              (GoogleMapController controller) {
                                            _controller.complete(controller);
                                          },
                                          zoomControlsEnabled: false,
                                          myLocationEnabled: true,
                                          mapToolbarEnabled: false,
                                          myLocationButtonEnabled: false,
                                          markers: const {
                                            // Marker(
                                            //   markerId:
                                            //       const MarkerId("userLocation"),
                                            //   position: LatLng(
                                            //     controller.currentlat.value,
                                            //     controller.currentlng.value,
                                            //   ),
                                            //   infoWindow: const InfoWindow(
                                            //     title: "Current Location",
                                            //   ),
                                            //   icon: BitmapDescriptor
                                            //       .defaultMarkerWithHue(
                                            //           BitmapDescriptor.hueRose),
                                            // ),
                                          },
                                        ),
                                      ),
                                    ),
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 40,
                                          color: Colors.pink,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    CustomButtom(
                      white: MediaQuery.sizeOf(context).width / 2,
                      title: "Create Customer",
                      onTap: () {
                        controller.createCusomter();
                      },
                      disble: controller.checkButton(),
                    ),
                  ],
                ),
              ),
              if (controller.isloading.value)
                Container(
                  color: Colors.transparent,
                  // color: Colors.black.withOpacity(0.2),
                  child: const Center(
                    child: CustomLoading(),
                  ),
                )
            ],
          ),
        ));
  }
}
