import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:googlemap_ui/modules/login/screen/login_screen.dart';
import 'package:googlemap_ui/utils/widgets/custom_alert.dart';
import 'local_storage.dart';
import 'url.dart';

class ErrorModel {
  final int? statusCode;
  final dynamic bodyString;
  const ErrorModel({this.statusCode, this.bodyString});
}

enum METHODE {
  get,
  post,
  delete,
  put,
}

class ApiBaseHelper {
  final dio = Dio();

  static final ApiBaseHelper apiBaseHelper = ApiBaseHelper._internal();
  ApiBaseHelper._internal();
  static ApiBaseHelper get obj => apiBaseHelper;
  Future<dynamic> onNetworkRequesting({
    required String url,
    Map<String, String>? header,
    Map<String, dynamic>? body,
    required METHODE? methode,
    required bool isAuthorize,
    String base = '',
  }) async {
    final token = await LocalStorage.getStringValue(key: 'access_token');
    final fullUrl = base == '' ? baseUrl + url : base + url;
    Map<String, String> headerDefault = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': isAuthorize ? 'Bearer $token' : '',
    };
    try {
      switch (methode) {
        case METHODE.get:
          final response = await dio.get(fullUrl,
              options: Options(headers: header ?? headerDefault), data: body);
          return _returnResponse(response);
        case METHODE.post:
          final response = await dio.post(
            fullUrl,
            options: Options(
              headers: header ?? headerDefault,
              sendTimeout: const Duration(minutes: 2),
              followRedirects: false,
            ),
            data: body ?? {},
          );
          return _returnResponse(response);
        case METHODE.put:
          final response = await dio.put(fullUrl,
              options: Options(headers: header ?? headerDefault),
              data: body ?? {});
          return _returnResponse(response);
        case METHODE.delete:
          final response = await dio.delete(fullUrl,
              options: Options(headers: header ?? headerDefault),
              data: body ?? {});
          return _returnResponse(response);
        default:
          break;
      }
    } catch (e) {
      debugPrint("On catch api $fullUrl");
      // CustomDialog.info(
      //   barrierDismissible: false,
      //   title: "Oops!",
      //   message: "SOMETHING WENT WRONG WITH YOUR ACCOUNT PLEASE TRY AGAIN",
      //   // ontap: () async {
      //   // await LocalStorage.storeData(key: "access_token", value: "");
      //   // Get.to(LoginScreen());
      //   // },
      // );
      return Future.error(e);
    }
  }

  dynamic _returnResponse(Response response) async {
    debugPrint("api code : ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 202:
        return response.data;
      case 404:
        return Future.error(
          ErrorModel(
            statusCode: response.statusCode,
            bodyString: response.data!,
          ),
        );
      case 400:
        CustomDialog.info(
            barrierDismissible: false,
            title: "Oops!",
            message: "SOMETHING WENT WRONG WITH YOUR ACCOUNT PLEASE TRY AGAIN",
            ontap: () async {
              await LocalStorage.storeData(key: "access_token", value: "");
              Get.to(LoginScreen());
            });
        return Future.error(ErrorModel(
            statusCode: response.statusCode, bodyString: response.data!));
      case 401:
        CustomDialog.info(
            barrierDismissible: false,
            title: "Oops!",
            message: "SOMETHING WENT WRONG WITH YOUR ACCOUNT PLEASE TRY AGAIN",
            ontap: () async {
              await LocalStorage.storeData(key: "access_token", value: "");
              Get.to(LoginScreen());
            });
        return Future.error(ErrorModel(
            statusCode: response.statusCode, bodyString: response.data!));
      case 403:
        CustomDialog.info(
            barrierDismissible: false,
            title: "Oops!",
            message: "SOMETHING WENT WRONG WITH YOUR ACCOUNT PLEASE TRY AGAIN",
            ontap: () async {
              await LocalStorage.storeData(key: "access_token", value: "");
              Get.to(LoginScreen());
            });
        return Future.error(ErrorModel(
            statusCode: response.statusCode, bodyString: response.data!));
      case 422:
        return Future.error(ErrorModel(
            statusCode: response.statusCode, bodyString: response.data!));
      case 500:
        break;
      default:
    }
  }
}
