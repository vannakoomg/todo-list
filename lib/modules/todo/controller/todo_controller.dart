import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/todo/screen/map_detail.dart';
import 'package:map_launcher/map_launcher.dart';

class TodoController extends GetxController {
  void showMapDetail(BuildContext context) {
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.95,
            child: const MapDetail());
      },
    );
  }

  void openGoogleMap(context, double lat, double lng) async {
    try {
      final coords = Coords(lat, lng);
      const title = "Ocean Beach";
      final availableMaps = await MapLauncher.installedMaps;
      debugPrint("map lenth ${availableMaps.length}");
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                          Container(
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
                              ]))
                      ])
                    ])));
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
