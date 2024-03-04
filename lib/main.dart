import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/themes/themes.dart';
import 'package:googlemap_ui/helpers/local_storage.dart';
import 'package:googlemap_ui/modules/home_screen/screen/home_screen.dart';
import 'package:googlemap_ui/modules/login/screen/login_screen.dart';
import 'package:googlemap_ui/utils/fuction.dart';

void getToken() async {
  String token = await LocalStorage.getStringValue(key: "access_token");
  Future.delayed(const Duration(milliseconds: 100), () {
    if (token != '') {
      Get.to(() => const HomeScreen());
    } else {
      Get.to(() => const LoginScreen());
    }
  });
}

void main() async {
  kkkkk();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  await dotenv.load(fileName: ".env");
  await LocalStorage.init();
  getToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightMode,
        home: const LoginScreen(),
      ),
    );
  }
}

// String encryptData(String data, String key) {
//   final keyBytes = utf8.encode(key);
//   final iv = keyBytes;
//   final encrypter = Encrypter(AES(Key(keyBytes as String), IV(iv)));
//   final encrypted = encrypter.encrypt(data, iv: IV(iv));
//   return encrypted.base64;
// }

