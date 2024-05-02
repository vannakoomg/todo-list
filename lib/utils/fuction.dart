// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:googlemap_ui/utils/context_unitity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';

import '../modules/todo/widgets/allow_location.dart';

Future unFocus() async {
  final FocusScopeNode currentFocus = FocusScope.of(ContextUtility.context!);
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

Map<String, DateTime> getStartAndEndOfWeek(DateTime date) {
  final int currentWeekDay = date.weekday;
  final DateTime startOfWeek =
      date.subtract(Duration(days: currentWeekDay - 1));
  final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
  return {
    "startOfWeek": startOfWeek,
    "endOfWeek": endOfWeek,
  };
}

String toTitleCase(String text) {
  // Determine the separator: Check if the text contains a hyphen
  String separator = text.contains('-') ? '-' : ' ';

  // Split the text based on the separator and capitalize each word
  return text.split(separator).map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
    return word;
  }).join(separator);
}

Future<String> getDeviceName(BuildContext context) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Theme.of(context).platform == TargetPlatform.android) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model;
  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.name;
  }
}

MemoryImage imageFromBase64String(String base64String) {
  return MemoryImage(base64Decode(base64String));
}

String formatDate(DateTime dateTimeString) {
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(dateTimeString);
  return formattedDate;
}

void openGoogleMap(
    {context,
    required double lat,
    required double lng,
    String title = ""}) async {
  try {
    final coords = Coords(lat, lng);
    final availableMaps = await MapLauncher.installedMaps;
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

Future checkPermission(BuildContext context) async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
  } else {
    await allowlocaiton(context);
  }
}

void kkkkk() {
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  // Text to be encrypted
  String originalText =
      "Hello, sad;kfskdajf;kadsjflkadsjf;lsadjf;ladsjf;ljsa;lfads;la;dslf;ladsf;la!";

  final encrypted = encrypter.encrypt(originalText, iv: iv);
  print('Encrypted: ${encrypted.base64}');

  // Decrypting
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print('Decrypted: $decrypted');
}
