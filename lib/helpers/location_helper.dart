import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../constantas/google_maps.dart';

class LocationHelper {
  static String getLocationImage({required String lat, required String long}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=14&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=$google_api_key";
  }

  static Future<String> getFormattedAdress(LatLng location) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&key=$google_api_key");

    final reponse = await http.get(url);

    final data = jsonDecode(reponse.body);
    // print(data);
    // print(data["results"][0]["formatted_address"]);
    return data["results"][0]["formatted_address"];
  }
}
