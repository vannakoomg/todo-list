// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';

Future unFocus(BuildContext context) async {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

openGoogleMap(context, double lat, double lng) async {
  try {
    final coords = Coords(37.759392, -122.5107336);
    const title = "Ocean Beach";
    final availableMaps = await MapLauncher.installedMaps;
    debugPrint("map lenth ${availableMaps.length}");
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                Text(
                  "Open In",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    for (var map in availableMaps)
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
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
                          ],
                        ),
                      )
                    // ListTile(
                    //   onTap: () => map.showMarker(
                    //     coords: coords,
                    //     title: title,
                    //   ),
                    //   title: Text(map.mapName),
                    // leading: Container(
                    //   clipBehavior: Clip.antiAlias,
                    //   height: 50.0,
                    //   width: 50.0,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //   ),
                    //   child: SvgPicture.asset(
                    //     map.icon,
                    //     fit: BoxFit.contain,
                    //   ),
                    //   ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    print(e);
  }
}
