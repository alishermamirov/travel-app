import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key});
  static const routeName = "/place_deatails";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final place = Provider.of<PlacesProvider>(context).getbyId(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            place.location.address,
          ),
          const SizedBox(
            height: 10,
          ),
          // TextButton(
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => MapScreen(
          //           placeLocation: PlaceLocation(
          //             latitude: place.location.latitude,
          //             logitude: place.location.logitude,
          //             address: "Jizzax",
          //           ),
          //           isSelecting: true,
          //         ),
          //       ));
          //     },
          //     child: Text("Manzilni ko'rish"))
        ],
      ),
    );
  }
}
