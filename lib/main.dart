import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/themes/themes.dart';
import 'package:googlemap_ui/helpers/local_storage.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/modules/login/screen/login_screen.dart';
import 'package:googlemap_ui/utils/context_unitity.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:sizer/sizer.dart';

import 'modules/bottom_navigetion/screen/buttom_navigetion_screen.dart';

final controller = Get.put(HomeController());
void main() async {
  kkkkk();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  await dotenv.load(fileName: ".env");
  await LocalStorage.init();
  controller.token.value =
      await LocalStorage.getStringValue(key: "access_token");
  controller.mode.value = await LocalStorage.getIntValue(key: "mode");
  debugPrint("token : ${controller.token.value}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GestureDetector(
            onTap: () {
              unFocus();
            },
            child: Obx(
              () => GetMaterialApp(
                navigatorKey: ContextUtility.navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                // theme: darkMode,
                theme: controller.mode.value == 0 ? lightMode : darkMode,
                home: controller.token.value == ""
                    ? LoginScreen()
                    : const BottomNavigetionScreen(),
              ),
            ));
      },
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

