// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';

Future unFocus(BuildContext context) async {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

Future<File> pickImage({ImageSource source = ImageSource.camera}) async {
  final ImagePicker picker = ImagePicker();
  var image = await picker.pickImage(source: source);
  debugPrint("iamge ${image!.path}");
  return File(image.path);
}

void openGoogleMap(context, double lat, double lng) async {
  try {
    final coords = Coords(lat, lng);
    const title = "Ocean Beach";
    final availableMaps = await MapLauncher.installedMaps;
    debugPrint("map lenth ${availableMaps.length}");
    if (availableMaps.length == 1) {
      availableMaps.first.showDirections(destination: coords);
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(children: [
                    Text(
                      "Open In",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      for (var map in availableMaps)
                        GestureDetector(
                          onTap: () {
                            map.showMarker(
                              coords: coords,
                              title: title,
                            );
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: SvgPicture.asset(
                                    map.icon,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(map.mapName),
                              ])),
                        )
                    ])
                  ])));
        },
      );
    }
  } catch (e) {
    debugPrint("$e");
  }
}
