import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places/models/place.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlaceProvider extends StateNotifier<List<Place>> {
  PlaceProvider() : super([]);
  
  Future<Database> _getDatabase() async {
    final databasesPath = await getDatabasesPath();

    //setting the string path for the database
    String path = join(
        databasesPath,
        'places.db');

    // creating the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version)  {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image Text)');
    });
    return database;
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    List<Map> list = await db.query('user_places');
    List<Place> newPlace = list.map((row) =>
        Place(id: row['id'], title: row['title'], image: File(row['image']))).toList();
    state = newPlace;
  }

  void addPlace(String title, File image) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final filename = basename(image.path);
    final copiedImage= await image.copy('${appDocumentsDir.path}/$filename');

    // inserting values in the database
    final newPlace = Place(title: title, image: copiedImage);
    state = [newPlace, ...state];
    final database = await _getDatabase();
    database.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }
}

final placeProvider =
    StateNotifierProvider<PlaceProvider, List<Place>>((ref) => PlaceProvider());
