import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayohat_dasturi/screens/add_place_screen.dart';

import '../providers/places_provider.dart';
import 'place_details_screen.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sayohat"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false).getplaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<PlacesProvider>(
              builder: (context, placeProvider, child) {
                if (placeProvider.list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: placeProvider.list.length,
                    itemBuilder: (context, index) {
                      final place = placeProvider.list[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(place.image),
                        ),
                        title: Text(place.title),
                        subtitle: Text(place.location.address),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              PlaceDetailsScreen.routeName,
                              arguments: place.id);
                        },
                      );
                    },
                  );
                } else {
                  return child!;
                }
              },
              child: const Center(
                child: Text("Ma'lumot mavjud emas"),
              ),
            );
          }
        },
      ),
    );
  }
}
