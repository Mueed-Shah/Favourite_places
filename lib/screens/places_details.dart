import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatefulWidget {
  const PlaceDetails({super.key,required this.item});
  final Place item;
  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:const Text('Details screen'),),
    body: Image.file(widget.item.image,
    fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    )
    );
  }
}
