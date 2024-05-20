import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? currentLocation;
  var _isLoading = false ;
  void addLocation() async{

    Location location =Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
setState(() {
  _isLoading = true ;

});
    locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    setState(() {
      _isLoading =false ;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget previewContent =const Text('No places selected yet');
    if(_isLoading){
      previewContent =const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1))),
            alignment: Alignment.center,
            child:previewContent),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [

            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                label: const Text('Get current location')),
            TextButton.icon(
                onPressed: addLocation,
                icon: const Icon(Icons.map),
                label: const Text('Select on Map'))
          ],
        )
      ],
    );
  }
}
