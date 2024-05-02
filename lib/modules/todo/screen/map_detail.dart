// ignore_for_file: prefer_collection_literals

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

class MapDetail extends StatefulWidget {
  final bool isSeletcLocation;
  final double lat;
  final double long;
  final String title;
  final Function? ontap;

  const MapDetail({
    super.key,
    required this.lat,
    required this.long,
    required this.title,
    this.ontap,
    this.isSeletcLocation = false,
  });

  @override
  State<MapDetail> createState() => MapDetailState();
}

class MapDetailState extends State<MapDetail> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double lat = 0.0;
  double lng = 0.0;
  @override
  void initState() {
    lat = widget.lat;
    lng = widget.long;
    super.initState();
  }

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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "close",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColor.secondnaryColor),
                      ),
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
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(widget.lat, widget.long), zoom: 14.23),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onCameraMove: (position) {
                        lat = position.target.latitude;
                        lng = position.target.longitude;
                      },
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      markers: {
                        if (widget.isSeletcLocation == false)
                          Marker(
                            markerId: const MarkerId("userLocation"),
                            position: LatLng(
                              widget.lat,
                              widget.long,
                            ),
                            infoWindow: const InfoWindow(
                              title: "Current Location",
                            ),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueRose),
                          ),
                      },
                    ),
                    if (widget.isSeletcLocation == true)
                      const IgnorePointer(
                        ignoring: true,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Icon(
                              Icons.location_on,
                              size: 40,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      )
                  ],
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
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(widget.lat, widget.long
                            // todoController.currentlat.value,
                            // todoController.currentlng.value,
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
                title: widget.isSeletcLocation == false
                    ? "Get Directions"
                    : "Drop",
                onTap: () {
                  if (widget.isSeletcLocation == false) {
                    openGoogleMap(
                      lat: widget.lat,
                      lng: widget.long,
                      context: context,
                      title: widget.title,
                    );
                  } else {
                    widget.ontap!(CameraPosition(
                      target: LatLng(
                        lat,
                        lng,
                      ),
                      zoom: 14.4746,
                    ));
                    Get.back();
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
