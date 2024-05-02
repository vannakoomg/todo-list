// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/todo/controller/check_in_controller.dart';
import 'package:googlemap_ui/modules/todo/screen/simple_google_map.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';

class CheckInScreen extends StatefulWidget {
  final String name;
  final double lat;
  final double long;
  final int checkInId;
  const CheckInScreen({
    super.key,
    required this.lat,
    required this.long,
    required this.name,
    required this.checkInId,
  });

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final controller = Get.put(ChcekinController());
  @override
  void initState() {
    controller.getaddress(widget.lat, widget.long);
    controller.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChcekinController());
    return Obx(() => Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: const CustomAppBar(title: "Check In"),
              body: Container(
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      bottom: 10, right: 10, left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop Name",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const Gap(5),
                            Text(
                              widget.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Address",
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                            const Gap(5),
                            Text(
                              controller.address.value,
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
                                controller.showMapDetail(context, widget.lat,
                                    widget.long, controller.address.value);
                              },
                              child: SizedBox(
                                height: 200,
                                child: SimpleGoogleMap(
                                  lat: widget.lat,
                                  long: widget.long,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                      CustomButtom(
                        white: 120,
                        title: "CHECK IN",
                        onTap: () async {
                          controller.ontapCheckIn(
                            context: context,
                            shopLat: widget.lat,
                            shopLong: widget.long,
                            checkInID: widget.checkInId,
                          );
                        },
                      )
                    ],
                  )),
            ),
            if (controller.isloading.value)
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.4),
                child: const Center(child: CustomLoading()),
              )
          ],
        ));
  }
}
