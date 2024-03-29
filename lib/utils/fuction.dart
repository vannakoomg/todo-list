// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';

import '../config/const/app_colors.dart';
import '../modules/todo/widgets/allow_location.dart';

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

Future alertError(BuildContext context) async {
  return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      title: "OOPS !",
      titleStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: AppColor.dangerColor),
      content: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Text(
            "SOMETHING WENT WRONG PLEASE TRY AGAIN",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ],
      ));
}
