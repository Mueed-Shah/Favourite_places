import 'package:favourite_places/screens/places_details.dart';
import 'package:flutter/material.dart';
import 'package:favourite_places/models/place.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;
  const PlacesList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text('Current list is Empty',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(places[index].image),
        ),
        title: Text(places[index].title),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlaceDetails(item: places[index]),
          ));
        },
      ),
    );
  }
}
