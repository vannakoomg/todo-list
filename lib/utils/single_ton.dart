import 'package:get/get.dart';

class Singleton extends GetxController {
  static Singleton? _obj;
  Singleton._();
  static Singleton get obj => _obj ??= Singleton._();
  final isCheckOut = false.obs;
}
