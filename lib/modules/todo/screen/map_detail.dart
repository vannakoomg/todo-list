// ignore_for_file: prefer_collection_literals

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/todo/controller/todo_controller.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

class MapDetail extends StatefulWidget {
  const MapDetail({super.key});

  @override
  State<MapDetail> createState() => MapDetailState();
}

class MapDetailState extends State<MapDetail> {
  final todoController = Get.put(TodoController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      11.570310254306118,
      104.89154143839733,
    ),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 50,
                child: Row(
                  children: [
                    Text(
                      "close",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColor.secondnaryColor),
                    ),
                    const Spacer(),
                    Text(
                      "Lcation",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text(
                      "close",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: {
                    Marker(
                      markerId: const MarkerId("userLocation"),
                      position: const LatLng(
                        11.570310254306118,
                        104.89154143839733,
                      ),
                      infoWindow: const InfoWindow(
                        title: "Current Location",
                      ),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRose),
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(bottom: 10, top: 60, left: 20, right: 20),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final GoogleMapController controller =
                          await _controller.future;
                      await controller.animateCamera(
                          CameraUpdate.newCameraPosition(const CameraPosition(
                        target: LatLng(
                          11.570310254306118,
                          104.89154143839733,
                        ),
                        zoom: 14.4746,
                      )));
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.secondnaryColor,
                        ),
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.pin_drop_rounded,
                        color: AppColor.secondnaryColor.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomButtom(
                colors: AppColor.secondnaryColor,
                white: MediaQuery.sizeOf(context).width * 0.6,
                title: "Get Directions",
                onTap: () {
                  openGoogleMap(
                      context, 11.568449483008305, 104.89069000146132);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
