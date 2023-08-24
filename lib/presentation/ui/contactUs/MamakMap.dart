import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MamakMapUi extends StatelessWidget {
  const MamakMapUi({Key? key, required this.controller, this.marker})
      : super(key: key);
  final MapController controller;
  final LatLng? marker;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        center: const LatLng(32.4279, 53.6880),
        zoom: 16.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        if (marker != null)
          MarkerLayer(markers: [
            Marker(
              point: marker!,
              builder: (context) => const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            )
          ]),
      ],
    );
  }
}
