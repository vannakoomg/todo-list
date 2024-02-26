import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/modules/home_screen/screen/report_checkout.dart';
import 'package:googlemap_ui/modules/todo/screen/todo_detail.dart';
import 'package:googlemap_ui/utils/widgets/custom_todo_card.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> requestPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
    } else {
      Location location = Location();
      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          debugPrint('Location permission denied');
        }
      }
    }
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(() => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            controller.date.value == ""
                                ? "TODAY"
                                : controller.date.value,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColor.secondnaryColor,
                                ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            controller.selectDate(context);
                          },
                          child: Icon(
                            Icons.calendar_month_rounded,
                            size: 22,
                            color: AppColor.secondnaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 0.5,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      margin: const EdgeInsets.only(top: 20),
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const ReportCheckOut());
                            },
                            child: const CustomTodoCard(
                              address:
                                  "Russian Federation Blvd (110), Phnom Penh",
                              stuts: 'checkout',
                              customer: "Nham Nha",
                              name: 'Nhanh Nha FIL',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const TodoDetail());
                            },
                            child: const CustomTodoCard(
                              customer: "tola",
                              stuts: '',
                              name: 'Coffee TTT',
                              address:
                                  "1006d Kampuchea Krom Blvd (128), Phnom Penh",
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
        ));
  }
}
