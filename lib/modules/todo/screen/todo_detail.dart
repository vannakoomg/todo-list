// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/checkOut/screens/checkout_screen.dart';
import 'package:googlemap_ui/modules/todo/controller/todo_controller.dart';
import 'package:googlemap_ui/modules/todo/screen/simple_google_map.dart';
import 'package:googlemap_ui/modules/todo/widgets/allow_location.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

import '../widgets/you_not_in_distance.dart';

class TodoDetail extends StatefulWidget {
  const TodoDetail({super.key});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final controller = Get.put(TodoController());
  @override
  void initState() {
    controller.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(title: "Todo Detail"),
      body: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          margin:
              const EdgeInsets.only(bottom: 10, right: 10, left: 10, top: 10),
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
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                    Text(
                      "Khmer",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Address",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                    Text(
                      "Khmersdjfsjdflkjdslfjsldfjlasdfjlsdjflksdjflsjdfjdslfjdslfjssdfjsdjfdsjfljsdalfjlsadjlkasjdfljsadfjsadj",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.showMapDetail(context);
                      },
                      child: const SizedBox(
                        height: 200,
                        child: SimpleGoogleMap(),
                      ),
                    )
                  ],
                ),
              )),
              CustomButtom(
                white: 120,
                title: "CHECK IN",
                onTap: () async {
                  // Get.to(() => const CheckOutScreen());
                  LocationPermission permission;
                  permission = await Geolocator.checkPermission();
                  if (permission == LocationPermission.always ||
                      permission == LocationPermission.whileInUse) {
                    double icsLat = 11.56114237395433;
                    double icsLong = 104.9261908345112;
                    double matherLat = controller.currentlat.value;
                    double matherLong = controller.currentlng.value;
                    double disabled = Geolocator.distanceBetween(
                        icsLat, icsLong, matherLat, matherLong);
                    if (disabled < 30) {
                      Get.to(() => const CheckOutScreen());
                    } else {
                      youNotinLocation(context);
                    }
                  } else {
                    allowlocaiton(context);
                  }
                },
              )
            ],
          )),
    );
  }
}
