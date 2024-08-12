import 'dart:io';

import 'package:flutter/material.dart';

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
  }

  Future<void> getplaces() async {
    notifyListeners();
  }

  Place getbyId(String id) {
    return list.firstWhere((element) => element.id == id);
  }
}
