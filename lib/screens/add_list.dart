import 'package:favourite_places/provider/user_places.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final TextEditingController _controller = TextEditingController();
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    void addPlace() {
      final addItem = _controller.text;
      if (addItem.isEmpty || selectedImage == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Enter Place'),
              content: const Text('Fill all the fields properly'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }
      ref.read(placeProvider.notifier).addPlace(addItem,selectedImage!);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding new places'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter a value',
                ),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                height: 15,
              ),
              ImageInput(onPickImage: (image)
              {selectedImage = image;}),
              const SizedBox(
                height: 15,
              ),
              const LocationInput(),
              const SizedBox(
                height: 15,
              ),
              TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  onPressed: addPlace,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Submit',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
