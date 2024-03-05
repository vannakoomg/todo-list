// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:googlemap_ui/helpers/url.dart';
import 'package:googlemap_ui/utils/single_ton.dart';
import '../../../helpers/local_storage.dart';

Future checkOutSale({
  double? lat,
  double? long,
  String? remark,
  int? checkInId,
  File? file,
}) async {
  final token = await LocalStorage.getStringValue(key: 'access_token');
  final userId = await LocalStorage.getIntValue(key: "user_id");
  String fileName = file != null ? file.path.split("/").last : "";
  FormData formData = FormData.fromMap({
    "user_id": userId,
    "photo_lat": lat,
    "photo_long": long,
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
      Singleton.obj.isCheckOut.value = true;
      debugPrint("done--------------------------- $value");
    });
  } on DioError catch (e) {
    Singleton.obj.isCheckOut.value = false;

    debugPrint("error--------------------------$e-");
  }
}

Future checkOutSaleWithOrder({
  double? lat,
  double? long,
  String? remark,
  int? checkInId,
  File? file,
}) async {
  // debugPrint("lat ====== > $lat")
  final token = await LocalStorage.getStringValue(key: 'access_token');
  final userId = await LocalStorage.getIntValue(key: "user_id");
  String fileName = file != null ? file.path.split("/").last : "";
  FormData formData = FormData.fromMap({
    "user_id": userId,
    "photo_lat": lat,
    "has_order": true,
    "photo_long": long,
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
      Singleton.obj.isCheckOut.value = true;
      debugPrint("check out with order--------------------------- $value");
    });
  } on DioError catch (e) {
    Singleton.obj.isCheckOut.value = false;

    debugPrint("error--------------------------$e-");
  }
}

Future<File> compressImage(File file) async {
  int vvv = await file.length();
  debugPrint("befor ${vvv / (1024 * 1024)}");
  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/temp.jpg";
  XFile? result;
  try {
    result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minHeight: 1920,
      minWidth: 1080,
      quality: 50,
    );
  } catch (e) {
    result = XFile("");
  }
  return File(result!.path);
}
