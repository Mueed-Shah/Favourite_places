import 'package:favourite_places/provider/user_places.dart';
import 'package:favourite_places/screens/add_list.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});

  @override
  ConsumerState<Places> createState() => _PlacesState();
}

class _PlacesState extends ConsumerState<Places> {
  late Future<void> _placeFuture;
  @override
  initState(){
    super.initState();
    _placeFuture = ref.read(placeProvider.notifier).loadPlaces();
  }
  @override
  Widget build(BuildContext context) {
    final List<Place> placesList = ref.watch(placeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YourPlaces',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body:
      FutureBuilder(future:_placeFuture , builder: (context, snapshot) =>
      snapshot.connectionState==ConnectionState.waiting ? const Center(child:
        CircularProgressIndicator(),): PlacesList(
        places: placesList,
      ),)

    );
  }
}
