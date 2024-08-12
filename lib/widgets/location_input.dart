// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../models/place.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function takepickerLocation;
  const LocationInput({
    Key? key,
    required this.takepickerLocation,
  }) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewLoactionImage;

  Future<void> _getCurrentLocation() async {
    try {
      Location location = Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      print(_serviceEnabled);
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      print(_permissionGranted);
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();
      // final _staticImage = LocationHelper.getLocationImage(
      //   lat: _locationData.latitude.toString(),
      //   long: _locationData.longitude.toString(),
      // );
      // setState(() {
      //   _previewLoactionImage = _staticImage;
      // });
      _getLocationImage(
        LatLng(_locationData.latitude!, _locationData.longitude!),
      );

      print(_locationData.latitude);
      print(_locationData.longitude);
    } catch (e) {
      rethrow;
    }
  }

  void _getLocationImage(LatLng location) async {
    setState(() {
      _previewLoactionImage = LocationHelper.getLocationImage(
        lat: location.latitude.toString(),
        long: location.longitude.toString(),
      );
    });
    final String FormattedAdress =
        await LocationHelper.getFormattedAdress(location);
    print(FormattedAdress);
    widget.takepickerLocation(
      location.latitude,
      location.longitude,
      FormattedAdress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
          ),
          child: _previewLoactionImage == null
              ? const Text("Location not selected")
              : Image.network(
                  _previewLoactionImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  _getCurrentLocation();
                },
                icon: const Icon(Icons.location_on),
                label: const Text("Mening manzilim"),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final LatLng selectedlocation =
                      await Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => MapScreen(
                      placeLocation: PlaceLocation(
                        lat: 40.13933755781848,
                        long: 67.81376427850017,
                        address: "Jizzax",
                      ),
                      isSelecting: true,
                    ),
                  ));
                  if (selectedlocation == null) {
                    return;
                  }
                  print(selectedlocation);
                  _getLocationImage(selectedlocation);
                },
                icon: const Icon(Icons.map),
                label: const Text("Xaritani ochish"),
              )
            ],
          ),
        )
      ],
    );
  }
}
