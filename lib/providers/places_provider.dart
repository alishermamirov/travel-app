import 'dart:io';

import 'package:flutter/material.dart';

import '../database/places_db.dart';
import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _list = [];
  List<Place> get list {
    return [..._list];
  }

  void addPlace(String title, File image, PlaceLocation placeLocation) {
    Place newPlace = Place(
        id: UniqueKey().toString(),
        title: title,
        location: placeLocation,
        image: image);
    _list.add(newPlace);
    notifyListeners();
    PlacesDb.insert(
      "user_places",
      {
        "id": newPlace.id,
        "title": newPlace.title,
        "image": newPlace.image.path,
        "lat": newPlace.location.lat,
        "long": newPlace.location.long,
        "adress": newPlace.location.address,
      },
    );
  }

  Future<void> getplaces() async {
    final placesList = await PlacesDb.getData("user_places");
    _list = placesList
        .map(
          (place) => Place(
            id: place["id"],
            title: place["title"],
            image: File(
              place["image"],
            ),
            location: PlaceLocation(
              lat: place["lat"],
              long: place["long"],
              address: place["adress"],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  Place getbyId(String id) {
    return list.firstWhere((element) => element.id == id);
  }
}
