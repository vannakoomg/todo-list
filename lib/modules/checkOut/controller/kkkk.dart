// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:googlemap_ui/helpers/url.dart';
import '../../../helpers/local_storage.dart';

Future checkOutSale({
  double? lat,
  double? long,
  String? remark,
  int? routeId,
  int? checkInId,
  File? file,
}) async {
  final token = await LocalStorage.getStringValue(key: 'access_token');
  final userId = await LocalStorage.getIntValue(key: "user_id");
  String fileName = file != null ? file.path.split("/").last : "";
  FormData formData = FormData.fromMap({
    "route_id": routeId,
    "user_id": userId,
    "latitude": lat,
    "longitude": long,
    "remark": remark,
    "check_in_id": checkInId,
    "photo": file!.path != ""
        ? await MultipartFile.fromFile(file.path, filename: fileName)
        : "",
  });
  try {
    Dio dio = Dio();
    await dio
        .post("$baseUrl/ppm_sale/api/check_out/activity",
            data: formData,
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }))
        .then((value) {
      debugPrint("done--------------------------- $value");
    });
  } on DioError catch (e) {
    debugPrint("error--------------------------$e-");
  }
}

Future checkOutSaleWithOrder({
  double? lat,
  double? long,
  String? remark,
  int? routeId,
  int? checkInId,
  File? file,
}) async {
  final token = await LocalStorage.getStringValue(key: 'access_token');
  final userId = await LocalStorage.getIntValue(key: "user_id");
  String fileName = file != null ? file.path.split("/").last : "";
  FormData formData = FormData.fromMap({
    "route_id": routeId,
    "user_id": userId,
    "latitude": lat,
    "has_order": true,
    "longitude": long,
    "remark": remark,
    "check_in_id": checkInId,
    "photo": file!.path != ""
        ? await MultipartFile.fromFile(file.path, filename: fileName)
        : "",
  });
  try {
    Dio dio = Dio();
    await dio
        .post("$baseUrl/ppm_sale/api/check_out_with_order/activity",
            data: formData,
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }))
        .then((value) {
      debugPrint("check out with order--------------------------- $value");
    });
  } on DioError catch (e) {
    debugPrint("error--------------------------$e-");
  }
}

Future compressImage(File file) async {
  int vvv = await file.length();
  debugPrint("befor $vvv");
  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/temp.jpg";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,

    minHeight: 1920,
    minWidth: 1080,
    // targetPath,
    quality: 2,
    // rotate: 180,
  );
  vvv = await result!.length();

  print("after $vvv");
  // print(result!.lengthSync());

  return result;
}
