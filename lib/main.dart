import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:googlemap_ui/config/themes/themes.dart';
import 'package:googlemap_ui/modules/todo/screen/simple_google_map.dart';
import 'package:googlemap_ui/modules/home_screen/screen/home_screen.dart';
import 'package:googlemap_ui/utils/fuction.dart';

// void hoho() {
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     LocationPermission permission;
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse) {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       debugPrint("lat long $position");
//       double disabled = Geolocator.distanceBetween(position.latitude,
//           position.longitude, 11.561913940120379, 104.92535095384278);
//       debugPrint("m $disabled");
//     }
//   });
// }

void main() {
  // hoho();
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
        home: const HomeScreen(),
      ),
    );
  }
}
