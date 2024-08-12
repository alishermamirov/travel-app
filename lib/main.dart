import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/places_list_screen.dart';
import 'providers/places_provider.dart';
import 'screens/add_place_screen.dart';
import 'screens/place_details_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlacesProvider>(
          create: (context) => PlacesProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (context) => const PlaceDetailsScreen(),
          //  MapScreen.routeName: (context) => MapScreen(),
        },
      ),
    );
  }
}
