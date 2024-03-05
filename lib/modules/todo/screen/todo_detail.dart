// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/todo/controller/todo_controller.dart';
import 'package:googlemap_ui/modules/todo/screen/simple_google_map.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';

class TodoDetail extends StatefulWidget {
  final String name;
  final double lat;
  final double long;
  final int checkInId;
  const TodoDetail({
    super.key,
    required this.lat,
    required this.long,
    required this.name,
    required this.checkInId,
  });

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final controller = Get.put(TodoController());
  @override
  void initState() {
    controller.getaddress(widget.lat, widget.long);
    controller.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoController());
    return Obx(() => Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: const CustomAppBar(title: "Todo Detail"),
              body: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10)),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                            ),
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
                              height: 10,
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
