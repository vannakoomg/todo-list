import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:googlemap_ui/persmition.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({super.key});

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  @override
  void initState() {
    determinePosition();
    super.initState();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google map")),
      body: isloading == true
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isloading = true;
                    });
                    LocationPermission permission;
                    permission = await Geolocator.checkPermission();
                    if (permission == LocationPermission.always ||
                        permission == LocationPermission.whileInUse) {
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      setState(() {
                        isloading = false;
                      });
                      debugPrint("lat long $position");
                      double icsLat = 11.561267332172669;
                      double icsLong = 104.92612366046919;
                      double matherLat = position.latitude;
                      double matherLong = position.longitude;
                      double disabled = Geolocator.distanceBetween(
                          icsLat, icsLong, matherLat, matherLong);
                      debugPrint("disten $disabled");

                      debugPrint(" $disabled meter ");
                    } else {
                      Geolocator.openLocationSettings();
                    }
                  },
                  child: const Text("get location "))),
    );
  }
}
