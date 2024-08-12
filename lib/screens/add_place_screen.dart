import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayohat_dasturi/widgets/image_input.dart';

import '../models/place.dart';
import '../providers/places_provider.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName = "/add-place";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? _savedImage;
  String _title = "";
  PlaceLocation? _placeLocation =
      PlaceLocation(lat: 75, long: 54, address: "adsf");
  final _formKey = GlobalKey<FormState>();
  void _takeSaveImage(savedImage) {
    _savedImage = savedImage;
  }

  void _takepickerLocation(double lat, double long, String adress) {
    _placeLocation = PlaceLocation(
      lat: lat,
      long: long,
      address: adress,
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate() &&
        _savedImage != null &&
        _placeLocation != null) {
      _formKey.currentState!.save();
      Provider.of<PlacesProvider>(context, listen: false)
          .addPlace(_title, _savedImage!, _placeLocation!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Sayohat joyini qo'shish"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Joy nomi",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "iltimos joy nomini kiriting";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _title = newValue!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ImageInput(takeSaveImage: _takeSaveImage),
                        const SizedBox(
                          height: 20,
                        ),
                        LocationInput(takepickerLocation: _takepickerLocation),
                      ],
                    ),
                  )),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _submit();
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
                backgroundColor: Colors.teal.withOpacity(0.5),
              ),
              child: const Text("Qo'shish"))
        ],
      ),
    );
  }
}
