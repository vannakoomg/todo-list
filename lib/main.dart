import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:googlemap_ui/config/themes/themes.dart';
import 'package:googlemap_ui/helpers/local_storage.dart';
import 'package:googlemap_ui/modules/login/screen/login_screen.dart';
import 'package:googlemap_ui/utils/fuction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await LocalStorage.init();
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
