import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/places_list_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PlaceListScreen(),
      // routes: {
      // AddPlacesScreen.routeName: (context) => const AddPlacesScreen(),
      // PlaceDetailScreen.routeName: (context) => const PlaceDetailScreen(),
      //  MapScreen.routeName: (context) => MapScreen(),
      // },
    );
  }
}
