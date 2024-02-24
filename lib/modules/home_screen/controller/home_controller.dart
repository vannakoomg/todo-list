import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final datetime = DateTime.now().obs;
  final date = ''.obs;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      // barrierColor: Colors.pink,
      context: context,
      initialDate: datetime.value,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue, // Change this to your desired color
            ),
            dialogBackgroundColor: Colors.white, // Background color
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != datetime.value) {
      datetime.value = picked;
      date.value = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
