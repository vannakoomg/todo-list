// ignore_for_file: prefer_collection_literals

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';

class SimpleGoogleMap extends StatefulWidget {
  const SimpleGoogleMap({super.key});

  @override
  State<SimpleGoogleMap> createState() => SimpleGoogleMapState();
}

class SimpleGoogleMapState extends State<SimpleGoogleMap> {
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
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          height: 200,
          child: AbsorbPointer(
            absorbing: true,
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
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.secondnaryColor, width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ],
    );
  }
}
