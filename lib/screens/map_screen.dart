// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';


class MapScreen extends StatefulWidget {
  final PlaceLocation placeLocation;
  final bool isSelecting;

  const MapScreen({
    Key? key,
    required this.placeLocation,
    required this.isSelecting,
  }) : super(key: key);

  static const routeName = "map-screen";
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _picLocation;

  void _setLocation(LatLng location) {
    print(location);
    setState(() {
      _picLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manzilni belgilang"),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _picLocation == null
                  ? null
                  : () => Navigator.of(context).pop(_picLocation),
              icon: const Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.placeLocation.lat,
            widget.placeLocation.long,
          ),
          zoom: 14,
        ),
        onTap: widget.isSelecting ? _setLocation : (LatLng location) {},
        markers: widget.isSelecting && _picLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId("m1"),
                  position: _picLocation ??
                      LatLng(widget.placeLocation.lat,
                          widget.placeLocation.long),
                ),
              },
      ),
    );
  }
}
