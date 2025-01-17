import 'package:sonicity/src/models/models.dart';

class TopAlbums {
  final List<Album> albums;
  TopAlbums({required this.albums});

  factory TopAlbums.fromJson({required List<Album> jsonList}) {
    return TopAlbums(albums: jsonList);
  }

  factory TopAlbums.empty() {
    return TopAlbums(albums: []);
  }

  void clear() {
    albums.clear();
  }
}